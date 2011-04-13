From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 13 Apr 2011 23:58:12 +0200
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <BANLkTi=8HEysFXhcv5yn=ErWZkzzqPoSug@mail.gmail.com>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
	<20110412133633.GR15130@legolas.emea.dhcp.ti.com>
	<1302634039.14216.10.camel@dev.znau.edu.ua>
	<BANLkTi=0sM2+nPYyd09G=Uy9rcEvaFErnA@mail.gmail.com>
	<1302635550.14216.21.camel@dev.znau.edu.ua>
	<BANLkTi=8mB9ZDTjF4yds6mkx+PmM+B_6Cg@mail.gmail.com>
	<4DA4AC4B.90409@hauke-m.de>
	<BANLkTiknRYWaDM1ThAxgXcdGqK8jeFaBPA@mail.gmail.com>
	<BANLkTikqKtJuDS17mfFvxzMoXuBtJvCgTA@mail.gmail.com>
	<1302640546.14216.65.camel@dev.znau.edu.ua>
	<BANLkTim8dmTL-BVK3fcWHNBU9Eyz1k_T+Q@mail.gmail.com>
	<op.vtvalzu33ri7v4@arend-laptop>
	<BANLkTik6JZ-n3sVjCFK_x1yNRH3_o3_6rg@mail.gmail.com>
	<1302726187.7911.11.camel@dev.znau.edu.ua>
	<BANLkTi=8HEysFXhcv5yn=ErWZkzzqPoSug@mail.gmail.com>
Message-ID: <BANLkTinXnZzF_1XkdDpuHsL-NWDd03VREw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/13 Rafa? Mi?ecki <zajec5@gmail.com>:
> Will comment on that later.

Can we try to decide, how to implement our driver correctly? This
should be main focus for now. I tried to analyze drivers/amba/, how it
works, how it relates to our code, Broadcom.

AFAICS AMBA so far is mostly (always?) used for embedded devices with
pre-defined hardware layout. Let's take as example mach-u300 (just
some random one). One of the amba_devices it registers is uart0_device
which has two interesting fields:
.start = U300_UART0_BASE,
.end   = U300_UART0_BASE + SZ_4K - 1,
U300_UART0_BASE == (U300_SLOW_PER_PHYS_BASE+0x3000) == 0xc0013000
So this mach-u300 is well-specified device, every mach-u300 has uart0
at 0xc0013000.

It looks every AMBA device (like uart0) has some common fields, like:
u32 peripherialid0, peripherialid1, peripherialid2, peripherialid3;
u32 componentid0, componentid1, componentid2, componentid3;

I believe Broadcom's *agent* AKA *wrapper* is comparable to standard
amba device.

Of course agents/wrappers are not the same for every Broadcom AMBA AXI
card, so we can not use strict .start and .end declarations and the
same agents/wrappers for every card. Instead, we have to do scanning
of EPROM to read info about agents/wrappers.

If someone does not know: every core on Broadcom AMBA AXI card has
it's agent/wrapper. We access agent/wrapper registers to
enable/disable/reset core.

So we could scan EPROM for agents/wrappers, register them in AMBA
driver using our *_core_enable as AMBA's clock management.


Please verify if my understanding is correct. I tried to explain
easily whole situation I just analyzed.

If I'm right: is this really the right path to follow? What about real
core, like PCIe core, or IEEE core? I guess they are not standard AMBA
cores, so we can not simply register them. Should we look for clever
way to connect everything we have with drivers/amba? How to connect
"real" cores (PCIe, IEEE) with agents?

Please, share how do you see this situation now.

-- 
Rafa?
