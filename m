From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 3 Jun 2014 14:12:31 +0300
Subject: [PATCH v1] of/irq: do irq resolution in platform_get_irq_byname()
In-Reply-To: <20140603092050.F0FD0C40D3B@trevor.secretlab.ca>
References: <1400582523-22684-1-git-send-email-grygorii.strashko@ti.com>	<20140523080333.66720C4176E@trevor.secretlab.ca>	<CAGa+x85mOHtNAj-UHgK2_z8zWAF=qwFcRcUgHTR-byNiX7heHA@mail.gmail.com>	<CAL_JsqLm3wfVS+au+JUbhBhxz=LuVpepH6GxabCQhPowhbw77g@mail.gmail.com>	<20140528071855.GJ4227@lee--X1>	<CACRpkdYgkEOjLamYu5uKSgs3iTNJ-w5XkbeygKjRdR-bNdETfg@mail.gmail.com>	<CAGb2v64f8Wju6dtVuVN2x=9YVGA-=RXozzhpJZNspKZ05f=jtA@mail.gmail.com>	<CACxGe6ts-TcSKk2F0-XSxAxeTxVCiyDHgh-O12v+F2OjHUsPyg@mail.gmail.com>	<5385B566.2050600@ti.com>
 <7h7g4zz7s4.fsf@paris.lan> <20140603092050.F0FD0C40D3B@trevor.secretlab.ca>
Message-ID: <538DAD9F.1030008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/03/2014 12:20 PM, Grant Likely wrote:
> On Mon, 02 Jun 2014 07:48:59 -0700, Kevin Hilman <khilman@linaro.org> wrote:
>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>
>>> Hi All,
>>>
>>> On 05/28/2014 12:03 PM, Grant Likely wrote:
>>
>> [...]
>>
>>>> The bisected patch causes platform_get_irq() to always parse the
>>>> devicetree to obtain the irq instead of using a precalculated value in
>>>> the platform_device. There are two possible scenarios for this problem
>>>> that I can think of:
>>>> 1) Platform_get_irq() is getting called multiple times (which would
>>>> happen on a deferred probe) but the setup code isn't handling it
>>>> properly, like trying to request the GPIO more than once
>>>> 2) the platform_device was preloaded with an irq number that differs
>>>> from what is determined when parsing the tree. This would happen if a
>>>> platform_device was created manually.
>>>>
>>>
>>> Could anyone try attached patch? It has to improve situation, but it
>>> might not fix all problems (see my previous e-mail).
>>
>> I can confirm it makes the STE Snowball boot again on top of next-20150602.
>>
>>>  From 4a41912dba648c935982274966426fa430fd5aa4 Mon Sep 17 00:00:00 2001
>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>> Date: Wed, 28 May 2014 12:53:34 +0300
>>> Subject: [PATCH] mfd: ab8500: fix dt irq mapping
>>>
>>> The AD8500 defines itself as interrupt-controller in DT,
>>> but it doesn't assign DT node to IRQ domain when creates it.
>>> As result, of_irq_xx() helpers don't work because they can't
>>> find necessary IRQ domain.
>>>
>>> Hence, fix it by assigning AD8500 core device DT node to IRQ
>>> domain when it's created.
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Tested-by: Kevin Hilman <khilman@linaro.org>

Thanks for testing it.

> 
> So is that it, or were there other problems? If it is then you can add

This is minimal solution and some sub-devices of ab8500 MFD may still 
not work.

For example, ab8500-debugfs may not work (ste-dbx5x0.dtsi):
	ab8500-debugfs {
		compatible = "stericsson,ab8500-debug";
	};

 and its DT definition may need to be updated to explicitly define IRQs,
smth like this:
	ab8500-debugfs {
		compatible = "stericsson,ab8500-debug";
		interrupts = <0 IRQ_TYPE_LEVEL_HIGH
			      111 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "IRQ_FIRST", "IRQ_LAST";
	};

> my acked-by when applying.
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> 

I've reposted this patch already:
 https://lkml.org/lkml/2014/6/2/379

Regards,
-grygorii
