From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Dec 2011 00:19:51 -0500 (EST)
Subject: [PATCH] arm: add default value for PHYS_OFFSET Kconfig setting
In-Reply-To: <CAP=VYLrp1zqyOzU-xzatF3jE3wL6wBjEDMR=sEXimP2ZvkQ0Lg@mail.gmail.com>
References: <1322711557-8279-1-git-send-email-paul.gortmaker@windriver.com>
 <201112011419.46751.arnd@arndb.de>
 <CAP=VYLrp1zqyOzU-xzatF3jE3wL6wBjEDMR=sEXimP2ZvkQ0Lg@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1112020005270.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Dec 2011, Paul Gortmaker wrote:

> On Thu, Dec 1, 2011 at 9:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 01 December 2011, Paul Gortmaker wrote:
> >> Commit 1b9f95f8ade9efc2bd49f0e7b9dc61a038ac3eef introduced the new
> >> Kconfig for PHYS_OFFSET but it did not specify a default value.
> >>
> >> This has the undesired side effect of breaking an implictly used
> >> trick for updating defconfigs on the fly for routine buildtesting
> >> across all arch and all platforms, i.e.
> >>
> >> ? cp /path/to/somedefconfig .config ; yes "" | make oldconfig
> >>
> >
> > FWIW, a better way to achieve the above is using
> >
> > make KCONFIG_ALLCONFIG=/path/to/somedefconfig listnewconfig alldefconfig
> >
> > which does not have this problem.
> >
> > Your patch looks still ok, but you might want to update your scripts
> > to be more robust.
> 
> Thanks -- but on the other hand, the above use case does actually
> emulate exactly what happens when someone runs the
> "make oldconfig" and simply holds down the Enter key. (yes it
> happens probably way more than we want to know...)
> 
> So, I guess what I'm trying to say is that the above "script" is
> intentionally fragile.  :)  As a use case, we shouldn't break it.

Well... I took a while before replying because I'm also modifying things 
around this, but those changes are good for a merge window not a -rc 
period.

Still, I don't think your patch is good, even as a temporary measure.  
The fact is that we can't just pick a random default value since it is 
likely to be wrong for the majority of the boards as the right answer 
for this option is quite varied.  So the fact that the config system 
insists on your entering a proper value is actually a good thing.

In the at91x40_defconfig case, it has CONFIG_EMBEDDED=y.  If it was not 
selected then you'd get CONFIG_ARM_PATCH_PHYS_VIRT=y by default and then 
no CONFIG_PHYS_OFFSET would be presented.

So the right fix here would actually consist of adding to 
at91x40_defconfig either CONFIG_ARM_PATCH_PHYS_VIRT=y, or a default 
value for CONFIG_PHYS_OFFSET which is the right value for that platform.


Nicolas
