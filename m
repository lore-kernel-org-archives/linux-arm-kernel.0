From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 18 Feb 2013 15:55:33 +0530
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <20130218101113.GB32688@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com> <20130218101032.GA32688@arwen.pp.htv.fi>
 <20130218101113.GB32688@arwen.pp.htv.fi>
Message-ID: <5122019D.9030100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013 03:41 PM, Felipe Balbi wrote:
> On Mon, Feb 18, 2013 at 12:10:32PM +0200, Felipe Balbi wrote:
>>> HWMOD_SWSUP_SIDLE flag will is not what will help UART completely.
>>> Also considering UART also needs async wakeup enabled as it implements
>>> another such hook and attaches that through function pointer.
>>
>> this is exactly what I said at [1], which I quote:
>>
>> "Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
>> there is still the regression of UART never being wakeup capable.
>>
I also mentioned that am not touching the wakeup function pointer. The
reason an alternate is needed because wakeup function pointer back-end
comes in between. And the existing SW control flag isn't intended
completely for the purpose what we wanted to use for uart. And I didn't
expected the wakeup crap will come in between an implementation of just
slave idle bits.

>> I wonder what are your ideas to sort that part out, I mean, how do you
>> plan to implement ->set_wake() for the tty port ?"
>
> [1] http://marc.info/?l=linux-omap&m=136093334914275&w=2
>
The main need for uart wakeup is the io_ring() trigger and that needs
to happen via generic pin control API. SYSC wakeup bit isn't something
needs to be toggled so that can be decoupled. So again the idea is
to make SYSC handling transparent to UART drivers and let driver toggle
the io_ring() based on ->set_wake() as it is done today.

Regards,
Santosh
