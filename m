From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 16 Mar 2010 10:49:48 +0200
Subject: [RFC/PATCH] ARM: add Tegra support
In-Reply-To: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
References: <4B96798C.6060201@compulab.co.il>
	<4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
Message-ID: <4B9F462C.7060902@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erik Gilling wrote:
> On Tue, Mar 9, 2010 at 9:38 AM, Mike Rapoport <mike@compulab.co.il> wrote:
>> This patch adds basic support for Nvidia Tegra2 platform.
> 
> This code seems to be our port from
> git://android.git.kernel.org/kernel/tegra.git with some features
> removed, minor cleanups, and many trivial changes.  These changes make
> it difficult for us to track improvements and bug fixes in either
> direction.  

Neither Nvidia nor Google showed any movements towards the mainline and
it was completely not clear if such plans exist at all. I've posted the 
patch a week ago and there were no comments from you since then. I'd be 
glad to see Tegra support in the mainline whether it'd be my patch or 
yours. I did my best to bring the basic Tegra support to a state that it 
can be merged into the mainline and I'll be happy to contribute to that 
support in the future.

> We're happy that other people are interested in our work
> however are disappointed that our opinions were not sought before
> making these changes and posting nor was any attribution given to the
> work's authors.

My apologies. Indeed, I should have make it clear that my work is based
on git://android.git.kernel.org/kernel/tegra.git

> We're still in the process here at Google of cleaning up the port for
> submission.  We should have our changes rebased on 34-rc1 without the
> android-common code by the end of the day.  We've been maintaining a
> patchstack which separates out the functional subsystems.  Would
> people here prefer to see that or a collapsed patch like this one.
> 
> Specific issues with this patch with respect to our work:
> 
> Lots of trival changes like moving files around, renaming variables,

I've moved the things around because in my opinion they belong to the 
places were I've put them.

> and re-wording/re-formating comments (sometimes changing the meaning
> of the comment incorrectly)

You are little bit exaggerating here. The wording was changed only in 
one comment and it doesn't seam to me to change the meaning.

> Removal of SMP, L2 cache, and pinmux support.

I've intended to add SMP, L2 and pinmux after the first hunk would be 
merged.

> Removal of the gpio_names header.  Because tegra does not define GPIOs
> numerically, it is impossible to convert a gpio name (i.e. PN6) from a
> schematic to a GPIO number without consulting and interpreting the
> datasheet.

The gpio_names header could have been added later, although I don't 
agree that it is essential to have it at all. Usually board file create 
their own defines for GPIOs that reflect actual GPIO usage, e.g. 
SOME_DEVICE_RST.

> Removal of the tegra_gpio_enable and tegra_gpio_disable functions.
> Because of the way pin muxing is implemented in tegra, gpio
> configuration does not map into the pinmuxing subsystem.

I've removed these functions because they were not referenced by any 
other code.

> Removal of pr_debug lines from the clock code.

I don't think that keeping pr_debug in each function is really good idea.

> Changing the way peripheral clocks are defined to use two separate
> tables which are required to be kept in sync by hand.

Having static clocks definition has its advantages. It simplifies the 
initialization code and saves several CPU cycles on boot. However, I 
agree that your approach may be better from the maintainability POV.

> Removal of some pll entries.

The plls were reordered, but I think none was removed.

> -Erik


-- 
Sincerely yours,
Mike.
