From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 14 Mar 2013 09:17:32 +0100
Subject: ARM: at-91: ARCH_AT91SAM9X5 went missing
In-Reply-To: <20130313122605.GE2001@game.jcrosoft.org>
References: <1363171688.3137.196.camel@x61.thuisdomein>
 <51405F0D.40102@atmel.com> <1363173747.3137.202.camel@x61.thuisdomein>
 <20130313122605.GE2001@game.jcrosoft.org>
Message-ID: <1363249052.1335.32.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 13:26 +0100, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> but the ARCH_AT91SAM9x5 never exist at the mainline

I'm not sure I understand this.

We're discussing the effects of commit
1e3ce2b8545390a2aee8dbfcd49ca4161b636000 ("AR[M]: at91: introduce
SOC_AT91xxx define to allow to compile SoC core support") here. It did
remove ARCH_AT91SAM9X5:
    $ git show 1e3ce2b8545390a2aee8dbfcd49ca4161b636000 | grep ARCH_AT91SAM9X5
    -config ARCH_AT91SAM9X5
    @@ -93,8 +91,47 @@ config ARCH_AT91SAM9X5
    -obj-$(CONFIG_ARCH_AT91SAM9X5)	+= at91sam9x5.o
    -#ifdef CONFIG_ARCH_AT91SAM9X5
    -#if !defined(CONFIG_ARCH_AT91SAM9X5)

It also added SOC_AT91SAM9X5, and that symbol even triggers the
compilation of a file named at91sam9x5.c:
    $ git show 1e3ce2b8545390a2aee8dbfcd49ca4161b636000 | grep SOC_AT91SAM9X5
    +config SOC_AT91SAM9X5
    +obj-$(CONFIG_SOC_AT91SAM9X5)	+= at91sam9x5.o
    +#ifdef CONFIG_SOC_AT91SAM9X5
    +#if !defined(CONFIG_SOC_AT91SAM9X5)

And also note that ARCH_AT91SAM9X5 still is used as an (optional) dependency:
    $ git grep -n ARCH_AT91SAM9X5 v3.9-rc2
    v3.9-rc2:drivers/net/can/Kconfig:68:    depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5


Paul Bolle
