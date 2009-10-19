From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 17:56:07 +0100
Subject: [PATCH 16/46] davinci: Add MMC/SD support for DA830/OMAP-L137 EVM
In-Reply-To: <20091019163937.GA2869@mag.az.mvista.com>
References: <1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<20091019140752.GC13614@n2100.arm.linux.org.uk>
	<20091019163937.GA2869@mag.az.mvista.com>
Message-ID: <20091019165607.GI13614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 09:39:37AM -0700, Mark A. Greer wrote:
> On Mon, Oct 19, 2009 at 03:07:52PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Oct 16, 2009 at 12:09:20PM -0700, Kevin Hilman wrote:
> > > +static int da830_evm_mmc_get_ro(int index)
> > > +{
> > > +	int val, status, gpio_num = 33;
> > > +
> > > +	status = gpio_request(gpio_num, "MMC WP\n");
> > > +	if (status < 0) {
> > > +		pr_warning("%s can not open GPIO %d\n", __func__, gpio_num);
> > > +		return 0;
> > > +	}
> > > +	gpio_direction_input(gpio_num);
> > > +	val = gpio_get_value(gpio_num);
> > > +	gpio_free(gpio_num);
> > 
> > Should this really be requesting the gpio every time it wants to be
> > read?  This approach sounds wrong.  Why not just request the GPIO in
> > the platform initialisation code, setting its direction, and merely
> > reading it in this function?
> 
> This routine doesn't get called on every read.  AFAICT, its only called
> by mmc_sd_init_card() which is called during init and resume.  That seems
> like the logical time to check if the card is set to read-only since cards
> can be inserted and removed while the system is running.

My complaint is not about when this function is called, it's about what
is being done inside this function.
