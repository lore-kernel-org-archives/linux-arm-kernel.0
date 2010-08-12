From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 12 Aug 2010 11:48:41 +0900
Subject: [PATCH/RFC] Samsung device-table approach
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <AANLkTinfQporvvWoOmm2xXkPyU=e6w6coV=+K50Wp5TM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 9:03 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> I would like to start the discussion on the redesign of the way the
> Samsung platform devices are defined. The current solution has some
> important disadvantages that blocks the further kernel development.
>
> Samsung SoC family is quite large. Mainline kernel already has support
> for more than 8 representatives, each having different memory and irq
> map.
>
> Currently most of the base address and irq differences are hidden behind
> the includes and some common defines (usualy named S3C_PA_*). Some
> devices also have different variants that are specified by changing the
> device name to include the SoC version in it. Others have SoC specific
> callbacks (like gpio pin configuration) that are provided thought the
> platform data.
>
> There is a lot of code that is needed to handle all these variants and
> differences. It also differs in term of style and a way how some
> simmilar things are performed (like changing the device name or
> providing the default platform data).
>
> In 2009 Ben Dooks did a research and proposed a solution that is called
> a device table. This solution solves the most problematic issue.
> Different base addresses and irqs can be easily provided for the same
> device on different version SoC systems. This is achieved by having a
> single table for each SoC that contains all these resources and create
> all required platform devices dynamically on SoC init.
>
> The proposed solution was enough for s3c24xx SoC devices and some early
> s3c64xx devices. However since then some new devices has been merged to
> mainline, mainly for s5p SoC series. These devices have more than one
> base address or irq and does not fit well into that framework.
IMO it is safe to assume such devices have slim chances to become the majority.
The 'extra' parameters will be present in every instance of the IP
in the SoCs that have them, only their value may differ. So, why not
define a new structure with fields for such 'extra' parameters for such
devices and make them available to drivers from platform_data.
That will :-
 a) Keep the original and simple design of Ben Dooks intact.
 b) Avoid taking space more than needed for majority of 'simple' devices.


> I've extended his approach to handle such more advanced devices. The new
> version is capable of setting up devices with more than one irq,
> physical register areas or even a dma channel.
>
> I've also added support for the default platform data. It has been
> designed in such a way that it can handle different default data for
> each device instance for each SoC system. This requires a bit of C
> preprocessor in the includes but make it much easier to register
> particular device. With this new solution there is no need for calling a
> function for setting platform data in machine startup.
>
> The solution has been designed with the following assumptions:
> 1. to reduce the number of static structures compiled into the kernel
> that are not used at all
> 2. to reduce the memory used by the unused static structures once kernel
> has booted
People might later want to build and load drivers for 'unused' device ?

Also, since there is already underway a good effort towards unifying
kernel builds for different platforms at ARM level, it might be worthwile
to look at the problem from POV vaster than Samsung. And then,
implement only Samsung specific need to work with that stub.

my 2 cents.
