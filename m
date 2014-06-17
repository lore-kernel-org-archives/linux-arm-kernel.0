From: jkridner@gmail.com (Jason Kridner)
Date: Tue, 17 Jun 2014 12:25:11 -0400
Subject: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAF59A7@DBDE04.ent.ti.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QP=jqdKij3bg3qZKT8GAKTKP94XtDWR+rcJWnDME5ZNmUg@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAF59A7@DBDE04.ent.ti.com>
Message-ID: <CA+T6QP=Q0db33NU1g=9QrOUqQhLfKg=UiHVSn=Loog_JFxtP1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 3:11 AM, Gupta, Pekon <pekon@ti.com> wrote:
> Hi Jason,
>
>>From: Jason Kridner
>>
>>Adding devicetree and linux-arm-kernel lists based on feedback on IRC...
>>
>>On Tue, Jun 10, 2014 at 12:46 PM, Jason Kridner <jkridner@gmail.com> wrote:
>>> I'd like to discuss moving our current library of cape devicetree
>>> overlay sources into a single tree, including the boot .dtb files for
>>> BeagleBoard.org boards and moving towards enabling as much of the cape
>>> support into a single boot-time .dtb file with an approach similar to
>>> the cape-universal overlay
>>> (https://github.com/cdsteinkuehler/beaglebone-universal-io), but not
>>> in an overlay.
>>>
>>> First of all, I want to note this doesn't change my view on the
>>> importance of mainline support for devicetree overlays. They are still
>>> absolutely critical and highly useful, solving problems that cannot be
>>> solved through boot-time devicetrees. I'm simply looking for an
>>> approach that will complement the availability of overlays and provide
>>> the best user experience.
>>>
>>> Robert has been talking about the actions required to clean-up Debian
>>> Jessie support in another thread
>>> (https://groups.google.com/d/msg/beagleboard/2b8rArtfABY/A8d1JzmJa4IJ)
>>> and I suggested we should add a bit of a detour by cleaning up the
>>> cape support for the mainline kernel and switching away our primary
>>> process of supporting capes from using overlays to using a single
>>> devicetree file provided at boot. I promised a pull-request and hadn't
>>> gotten around to sending it until now (below). No architecture changes
>>> have been made in my pull-request, just bringing in the kernel
>>> devicetree source history. This suggestion is based on several
>>> assumptions, any number of which might be wrong.
>>>
>>> The assumptions (for which I'm looking for feedback/corrections):
>>> * The overlays pretty much all need to be compiled into the kernel if
>>> they are going to be loaded using kernel command-line arguments or
>>> /etc/capemgr for the majority of distros. While many cape devicetree
>>> use cases are perfectly happy with loading at run-time rather than
>>> boot-time, it seems there should be a mechanism for pushing cape
>>> support into the category of being available at boot-time across
>>> distributions.
>>> * The devicetree sources, including the primary boot .dts files, will
>>> eventually be removed from the kernel source tree. I'm not too sure if
>>> and when it'll really happen, but starting up a project to maintain
>>> the definitive beagleboard.org board devicetree files outside the
>>> kernel seems to make sense. Given the interdependency of the boot .dtb
>>> and the overlay .dtbo files, combining them into a single repository
>>> where every distribution can pick them up seems like a natural and
>>> obvious choice. There are of course some dependencies on kernel
>>> versions, but I believe most of those have settled out by now and we
>>> should be OK moving forward.
>
> +1
> Yes, moving cape DTS out of kernel tree should help developers.
> There are quite a few cape patches floating in mail-lists, but as cape
> DTS is still not accepted in mainline so they get lost and forgotten.
> So one place for collecting all this is a good idea.
>
>
> However, somehow the universal I/O DTS looked seemed complicated:
> (1)
> All capes work standalone, but due to share pin-mux some cape
> combinations cannot be used simultaneously. But most users of
> BeagleBone are already well-versed with DT and kernel infrastructure,
> so they need not be spoon fed to get a out-of-box working solution
> for each combination. If there is proper documentation is available
> about compatibility of capes with each other, then users will figure
> out themselves.

I think you have too much confidence in users. If this doesn't hurt
power users, then why is it bad have an option to spoon feed? This
doesn't prevent anyone with knowledge of DT from doing their own
thing.

>
> (2)
> Also, there was a talk of enabling and disabling DT fragments via u-boot.
> That should also be explored instead of complicating cape DTS.

Link? Relevance?

>
> (3)
> BeagleBone community and outside are coming out with new featured
> capes, which might possess a challenge to get a absolute non-conflicting
> universal I/O DTS. What might be working today might have conflicts
> tomorrow with introduction of new capes.
> We should be open to be compatible to capes developed outside
> Beaglebone.org. In my view this is important for longer term.
> Example: http://valentfx.com/logi-bone/

The tree isn't only for beagleboard.org, but anyone building add-on
boards for beagleboard.org boards. In fact, there are 0 official
add-on boards from beagleboard.org as of now. CircuitCo makes a bunch
and I believe there are some coming from TI soon, but there are none
from beagleboard.org itself and most capes come from other parties.
Registry is at http://beaglebonecapes.com and
http://beagleboard.org/cape.

>
> So, plz review my feedback and if you plan to create an external tree
> for beaglebone Capes, I would be happy to submit some cape patches.

Great. https://github.com/beagleboard/devicetree-source

>
>
> with regards, pekon
