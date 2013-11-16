From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 16 Nov 2013 23:52:08 +0100
Subject: Warning masked by BUG() when CONFIG_BUG is enabled
Message-ID: <87a9h4559j.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While compiling a kernel, I got the following warnings which are due to
missing returns in the following functions:

  CC      fs/xattr.o
  CC      crypto/cryptd.o
  CC      lib/irq_regs.o
  CC      lib/is_single_threaded.o
  CC      lib/klist.o
drivers/gpio/gpio-mvebu.c: In function ?mvebu_gpioreg_edge_mask?:
drivers/gpio/gpio-mvebu.c:148:1: warning: control reaches end of non-void function [-Wreturn-type]
drivers/gpio/gpio-mvebu.c: In function ?mvebu_gpioreg_edge_cause?:
drivers/gpio/gpio-mvebu.c:130:1: warning: control reaches end of non-void function [-Wreturn-type]
drivers/gpio/gpio-mvebu.c: In function ?mvebu_gpioreg_level_mask?:
drivers/gpio/gpio-mvebu.c:166:1: warning: control reaches end of non-void function [-Wreturn-type]
  CC      lib/kobject.o
  CC      lib/kobject_uevent.o
  CC      lib/md5.o
  CC      lib/percpu-refcount.o

I was kind of curious not to have noticed it during kernel builds for
armada 370/xp targets. The reason is the following: on my Armada 370/XP
builds, I had CONFIG_BUG=y which makes BUG() call panic() (which never
returns). Otherwise, BUG() is a nop and the 'default' branch below is no
more a catch-all barrier in previous functions. For the discussion,
those have the same structure:

static inline void __iomem *mvebu_gpioreg_edge_cause(...)
{
	int cpu;

	switch (mvchip->soc_variant) {
	case MVEBU_GPIO_SOC_VARIANT_ORION:
	case MVEBU_GPIO_SOC_VARIANT_MV78200:
		return sth;
	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
		return sth;
	default:
		BUG();
	}
}

*Out of curiosity*, are there no generic solutions to handle such a case?
In the end, if BUG() has been put here on purpose (i.e. this is the only
solution, which it kinds of looks like here) wouldn't it be more logical
to call panic() here directly?

As a side note, I noticed quite some instances of that pattern (switch
statement w/ a 'default' calling BUG()) while more carefully looking at
compilation output. I may get slapped for this, but just in case this
is indeed something which deserves to be fixed and can be fixed
automagically via some semantic patch, I have CC'ed Coccinelle people.

Cheers,

a+
