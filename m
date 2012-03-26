From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 26 Mar 2012 09:11:45 -0400
Subject: ioremap to a specific virtual address
In-Reply-To: <201203260847.38176.arnd@arndb.de>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <CAKON4OwhcFDMC4dWjU7x4u2CPT7C2BxVuCDkTN0j14gTndi3tA@mail.gmail.com>
 <201203251734.41780.arnd@arndb.de>
 <201203260847.38176.arnd@arndb.de>
Message-ID: <CAKON4OyPpTNHoWbYQ+jOHEF+c9Rz983wMjArsqkMnUKnYe_V0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 4:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 25 March 2012, Arnd Bergmann wrote:
>> ? ? ? ? ? ? ? ? ? ? ? ? /* mpmc configuration */
>> ? ? ? ? ? ? ? ? ? ? ? ? mpmc-static-config ? ? = <0x81>;
>> ? ? ? ? ? ? ? ? ? ? ? ? mpmc-static-wait-wen ? = <1>;
>> ? ? ? ? ? ? ? ? ? ? ? ? mpmc-static-wait-oen ? = <1>;
>> ? ? ? ? ? ? ? ? ? ? ? ? mpmc-static-wait-rd ? ?= <4>;
>> ? ? ? ? ? ? ? ? ? ? ? ? mpmc-static-wait-page ?= <1>;
>> ? ? ? ? ? ? ? ? ? ? ? ? mpmc-static-wait-write = <1>;
>> ? ? ? ? ? ? ? ? ? ? ? ? mpmc-static-wait-turn ?= <2>;
>
> On second though, I guess you can turn these into a single
> property named "mpmc-timings" or such and then just copy
> them to the registers.
>
> I also wonder whether the timings are actually correct for your
> dm9000 device. Maybe the additional gpio read in there was
> just an indication that someone worked around incorrect timings?

Maybe the GPIO read is bogus? Looks like they needed a 70ns delay and
the GPIO read was a way of getting that.

How do MPNC delays work? Shouldn't the CPU enforce this delay in hardware?

/* ARM MPMC contoller as part of low power design doesn't de-assert
nCS and nOE for consecutive reads but just changes address. But DM9000
requires nCS and nOE change between address. So access other chip
select area (nCS0) to force de-assertion of nCS1 and nOE1. Or else
wait for long time such as 80 usecs.
LPC313x has external logic outside of MPMC IP to toggle nOE to split
consecutive reads.

The latest Apex bootloader patch makes use of this feature. For this
to work SYS_MPMC_WTD_DEL0 & SYS_MPMC_WTD_DEL1 should be programmed
with MPMC_STWTRD0 & MPMC_STWTRD1 values. The logic only deactivates
the nOE for one clock cycle which is 11nsec but DM9000 needs 80nsec
between nOEs. So lets add some dummy instructions such as reading a
GPIO register to compensate for extra 70nsec.
*/

WTD_DEL1
This following register is used for the static device0 of the MPMC. It
provides that the output enable signal for the static device0 (OE) is
split up into two equal portions, with one inactive cycle in the
middle. This is needed because some memories do no detect consecutive
reads within one OE period

MPMCStaticExtendedWait is set to 4 which should be a 2us delay.



-- 
Jon Smirl
jonsmirl at gmail.com
