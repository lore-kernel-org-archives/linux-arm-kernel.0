From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Mar 2013 16:09:03 +0100
Subject: [BUG][mvebu] mvneta: cannot request irq 25 on openblocks-ax3
In-Reply-To: <2482565.pAEcuMH9qj@bender>
References: <51486445.8040506@hitachi.com> <514873FB.5050202@hitachi.com>
 <514895C5.40706@free-electrons.com> <2482565.pAEcuMH9qj@bender>
Message-ID: <5149D10F.40605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 08:48 PM, Florian Fainelli wrote:
> On Tuesday 19 March 2013 17:43:49 Gregory CLEMENT wrote:
>>
>> Hi Masami,
>>
>> You can try this patch if you want.
>> I don't have the hardware today so I didn't test it.
>> If you (and also Florian and Ezequiel) can test it and if it fixed
>> the bug, then I will be able send a proper email for it,
> 
> I just tested your patch on RD-A370-A1 and DB-MV784MP-GP and it works fine, 
> thanks! Feel free to add my Tested-by: Florian Fainelli <florian@openwrt.org> 
> to your next submission.
> 
> Thanks!
> 
Thanks for having tested it, but with this patch there is still an issue when
we try to release the network interface. In this case the the interrupt line
is not properly freed.
Unfortunately the state of the percpu_irq API prevents the driver to use it.

Indeed the interrupts have to be freed when the .stop() function is
called. As the free_percpu_irq() function don't disable the interrupt
line, we have to do it on each CPU before calling this. The function
disable_percpu_irq() only disable the percpu on the current CPU and
there is no function which allows to disable a percpu irq on a given
CPU. Waiting for the extension of the percpu_irq API, this fix allows
to use again the mvneta driver.

I have just wrote and tested a new patch to fix this issue by just go back
on the old way we managed the irq for the mvenat as global irq and not
as local ones.

I am going to send the fix on the LAKML in a few minutes.

Thanks,

Gregory
