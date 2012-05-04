From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 12:56:30 +0000
Subject: [PATCH 3/9] ARM: mmp: support DT in irq
In-Reply-To: <CAN1soZwE7MoifmxtPS8f_x6CrK-dF97=vPMTMStg=VW1wsoLrA@mail.gmail.com>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <201205021251.16967.arnd@arndb.de>
 <CAN1soZwE7MoifmxtPS8f_x6CrK-dF97=vPMTMStg=VW1wsoLrA@mail.gmail.com>
Message-ID: <201205041256.30409.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Haojian Zhuang wrote:
> On Wed, May 2, 2012 at 8:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 02 May 2012, Haojian Zhuang wrote:
> >> I use two CONFIG_OF in this file. The first one is used to record
> >> register base address
> >> of interrupt controller. In legacy code, the register address is
> >> hardcoding. Do you mean
> >> that I should remove this CONFIG_OF?
> >
> > Unless it's a noticeable performance impact, I would recommend just
> > always using the mmp_icu_base variable, even for when CONFIG_OF is
> > disabled.
> 
> But I appended new irq handler for DT support. I still need to reserve
> this CONFIG_OF
> since I need to keep compatible with legacy code.

You don't need to worry about out-of-tree code, it can adapt. For the
non-DT version, why can't you move the 'mmp_icu_base' variable into
common.c and just initialize it to ICU_VIRT_BASE?
If you do that, any combination of DT- and non-DT board files should
work with the same entry-macro.S code.

Another alternative would be to convert MMP over to
CONFIG_MULTI_IRQ_HANDLER and use different handle_irq functions.

	Arnd
