From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 1 Apr 2013 18:32:36 -0400
Subject: [PATCH 0/3] add devicetree bindings for rtc-m48t86
In-Reply-To: <515A0632.3040902@gmail.com>
References: <1364766971-5914-1-git-send-email-alex@digriz.org.uk>
 <5159FFAA.5030205@gmail.com> <515A0632.3040902@gmail.com>
Message-ID: <20130401223236.GQ13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 09:12:02AM +1100, Ryan Mallon wrote:
> On 02/04/13 08:44, Ryan Mallon wrote:
> > On 01/04/13 08:56, Alexander Clouter wrote:
> >> Currently there are two users of rtc-m48t86 (mach-ep93xx/ts72xx.c and
> >> mach-orion5x/ts78xx-setup.c) and both just use {read,write}b against
> >> a memory mapped region.  As I am devicetree'ing the TS-7800, this
> >> driver needs converting and thats what this patchset does.
> >>
> >> The patch does the following:
> >>  * remove platform specific ops hooks, moving ioremap'ing and
> >> 	everything into the driver
> >>  * utilises named resources to indicate index/data ranges
> >>  * moves the RTC detection routine from ts78xx-setup.c into rtc-m48t86.c
> >>  * and, of course, enable devicetree hooks and include documentation
> >>
> >> Awkward step, the first patch breaks both boards, the two following
> >> patches fix them.  Happy to re-work this if folks give me a pointer
> >> on how to do this in an acceptable way.
> > 
> > Sorry, that's no good. It breaks things like git bisect.
> > 
> >>
> >> My vote is to break fast, fix fast, spend the time writing other code :)
> > 
> > The patch series will need to be reworked so that there is no
> > build/runtime breakage between any of the patches. I'll have a read
> > through and see if I can suggest something.
> 
> So looking through the patches, you are going to need to modify the rtc
> driver and the platform code in the same patch at least once since you
> are changing the interface. You could break the patches down like this:
> 
> 1) Move the rtc detection from the orion5x board to the rtc driver.
>    This adds the detection support for the ep93xx board also.
> 
> 2) Replace the board read/write ops structure with ioremapped regions.
> 
> 3) Add the device tree bindings to the rtc driver.
> 
> The first two patches could be combined, but will touch both the rtc
> driver and the platform code, and do the prep work needed for adding the
> dt bindings. 

Please keep me and Andrew Lunn in the Cc: and once we see the final
series, I'll ack the platform changes for going though the rtc tree.
It's best to keep this series together, and the changes to the platform
code should be pretty isolated from other changes we are doing.

thx,

Jason.
