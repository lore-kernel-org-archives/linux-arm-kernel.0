From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Nov 2014 13:13:49 +0000
Subject: [PATCH v8 5/9] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <20141104130320.GB21210@tiger>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
 <1413888020-8790-6-git-send-email-linux@rempel-privat.de>
 <20141104130320.GB21210@tiger>
Message-ID: <20141104131349.GF4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 09:03:23PM +0800, Shawn Guo wrote:
> Thanks Jason for pointing me the thread.
> 
> On Tue, Oct 21, 2014 at 12:40:16PM +0200, Oleksij Rempel wrote:
> > +config IRQ_MXS
> > +	bool "MXS interrupt controller"
> > +	select IRQ_DOMAIN
> > +	select STMP_DEVICE
> > +	default y if MACH_ASM9260 || CONFIG_ARCH_MXS
> 
> s/CONFIG_ARCH_MXS/ARCH_MXS
> 
> Even with this change, the 'default y' doesn't seem to work for me.

The only way an option follows its default is if it doesn't have a visible
prompt.  So:

config IRQ_MXS
	def_bool y if MACH_ASM9260 || ARCH_MXS
	select IRQ_DOMAIN
	select STMP_DEVICE

will cause it to always be defined to 'y' if either of those options are
enabled.  Otherwise, if it has a visible prompt, it follows (in order of
precedence) whatever the user specifies, the configuration file, or the
Kconfig specified default, or 'n'.  (Each limited by selects and
dependencies.)

Is there a particular reason why the option is being offered for user
selection?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
