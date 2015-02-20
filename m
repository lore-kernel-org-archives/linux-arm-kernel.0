From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 20 Feb 2015 08:47:53 -0800
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <54E742F2.80506@hurleysoftware.com>
References: <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <20150218154106.GC29429@leverpostej>
 <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
 <20150218173115.GG29429@leverpostej>
 <76BD1B22-BAED-4205-9B34-186907CE0217@konsulko.com>
 <54E613E7.2020405@gmail.com>
 <670D0881-DBF0-45E8-A502-A6DB2B77A750@konsulko.com>
 <54E61DD2.3060002@gmail.com>
 <53F2F94C-0C43-4A54-B8CD-EEC454A0AC19@konsulko.com>
 <54E742F2.80506@hurleysoftware.com>
Message-ID: <20150220164753.GC22752@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 09:21:38AM -0500, Peter Hurley wrote:
> On 02/19/2015 12:38 PM, Pantelis Antoniou wrote:
> > 
> >> On Feb 19, 2015, at 19:30 , Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 2/19/2015 9:00 AM, Pantelis Antoniou wrote:
> >>> Hi Frank,
> >>>
> >>>> On Feb 19, 2015, at 18:48 , Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> On 2/19/2015 6:29 AM, Pantelis Antoniou wrote:
> >>>>> Hi Mark,
> >>>>>
> >>>>>> On Feb 18, 2015, at 19:31 , Mark Rutland <mark.rutland@arm.com> wrote:
> >>>>>>
> >>>>>>>>> +While this may in theory work, in practice it is very cumbersome
> >>>>>>>>> +for the following reasons:
> >>>>>>>>> +
> >>>>>>>>> +1. The act of selecting a different boot device tree blob requires
> >>>>>>>>> +a reasonably advanced bootloader with some kind of configuration or
> >>>>>>>>> +scripting capabilities. Sadly this is not the case many times, the
> >>>>>>>>> +bootloader is extremely dumb and can only use a single dt blob.
> >>>>>>>>
> >>>>>>>> You can have several bootloader builds, or even a single build with
> >>>>>>>> something like appended DTB to get an appropriate DTB if the same binary
> >>>>>>>> will otherwise work across all variants of a board.
> >>>>>>>>
> >>>>>>>
> >>>>>>> No, the same DTB will not work across all the variants of a board.
> >>>>>>
> >>>>>> I wasn't on about the DTB. I was on about the loader binary, in the case
> >>>>>> the FW/bootloader could be common even if the DTB couldn't.
> >>>>>>
> >>>>>> To some extent there must be a DTB that will work across all variants
> >>>>>> (albeit with limited utility) or the quirk approach wouldn't work?
> >>>>>>
> >>>>>
> >>>>> That?s not correct; the only part of the DTB that needs to be common
> >>>>> is the model property that would allow the quirk detection logic to fire.
> >>>>>
> >>>>> So, there is a base DTB that will work on all variants, but that only means
> >>>>> that it will work only up to the point that the quirk detector method
> >>>>> can work. So while in recommended practice there are common subsets
> >>>>> of the DTB that might work, they might be unsafe.
> >>>>>
> >>>>> For instance on the beaglebone the regulator configuration is different
> >>>>> between white and black, it is imperative you get them right otherwise
> >>>>> you risk board damage.
> >>>>>
> >>>>>>>> So it's not necessarily true that you need a complex bootloader.
> >>>>>>>>
> >>>>>>>
> >>>>>>>>> +2. On many instances boot time is extremely critical; in some cases
> >>>>>>>>> +there are hard requirements like having working video feeds in under
> >>>>>>>>> +2 seconds from power-up. This leaves an extremely small time budget for
> >>>>>>>>> +boot-up, as low as 500ms to kernel entry. The sanest way to get there
> >>>>>>>>> +is by removing the standard bootloader from the normal boot sequence
> >>>>>>>>> +altogether by having a very small boot shim that loads the kernel and
> >>>>>>>>> +immediately jumps to kernel, like falcon-boot mode in u-boot does.
> >>>>>>>>
> >>>>>>>> Given my previous comments above I don't see why this is relevant.
> >>>>>>>> You're already passing _some_ DTB here, so if you can organise for the
> >>>>>>>> board to statically provide a sane DTB that's fine, or you can resort to
> >>>>>>>> appended DTB if it's not possible to update the board configuration.
> >>>>>>>>
> >>>>>>>
> >>>>>>> You?re missing the point. I can?t use the same DTB for each revision of the
> >>>>>>> board. Each board is similar but it?s not identical.
> >>>>>>
> >>>>>> I think you've misunderstood my point. If you program the board with the
> >>>>>> relevant DTB, or use appended DTB, then you will pass the correct DTB to
> >>>>>> the kernel without need for quirks.
> >>>>>>
> >>>>>> I understand that each variant is somewhat incompatible (and hence needs
> >>>>>> its own DTB).
> >>>>>
> >>>>> In theory it might work, in practice this does not. Ludovic mentioned that they
> >>>>> have 27 different DTBs in use at the moment. At a relatively common 60k per DTB
> >>>>> that?s 27x60k = 1.6MB of DTBs, that need to be installed.
> >>>>
> >>>> < snip >
> >>>>
> >>>> Or you can install the correct DTB on the board.  You trust your manufacturing line
> >>>> to install the correct resistors.  You trust your manufacturing line to install the
> >>>> correct kernel version (eg an updated version to resolve a security issue).
> >>>>
> >>>> I thought the DT blob was supposed to follow the same standard that other OS's or
> >>>> bootloaders understood.  Are you willing to break that?  (This is one of those
> >>>> ripples I mentioned in my other emails.)
> >>>>
> >>>
> >>> Trust no-one.
> >>>
> >>> This is one of those things that the kernel community doesn?t understand which makes people
> >>> who push product quite mad.
> >>>
> >>> Engineering a product is not only about meeting customer spec, in order to turn a profit
> >>> the whole endeavor must be engineered as well for manufacturability.
> >>>
> >>> Yes, you can always manually install files in the bootloader. For 1 board no problem.
> >>> For 10 doable. For 100 I guess you can hire an extra guy. For 1 million? Guess what,
> >>> instead of turning a profit you?re losing money if you only have a few cents of profit
> >>> per unit.
> >>
> >> I'm not installing physical components manually.  Why would I be installing software
> >> manually?  (rhetorical question)
> >>
> > 
> > Because on high volume product runs the flash comes preprogrammed and is soldered as is.
> > 
> > Having a single binary to flash to every revision of the board makes logistics considerably
> > easier.
> > 
> > Having to boot and tweak the bootloader settings to select the correct dtb (even if it?s present
> > on the flash medium) takes time and is error-prone.
> > 
> > Factory time == money, errors == money.
> > 
> >>>
> >>> No knobs to tweak means no knobs to break. And a broken knob can have pretty bad consequences
> >>> for a few million units. 
> >>
> >> And you produce a few million units before testing that the first one off the line works?
> >>
> > 
> > The first one off the line works. The rest will get some burn in and functional testing if you?re
> > lucky. In many cases where the product is very cheap it might make financial sense to just ship
> > as is and deal with recalls, if you?re reasonably happy after a little bit of statistical sampling.
> > 
> > Hardware is hard :)
> 
> I'm failing to see how this series improves your manufacturing process at all.
> 
> 1. Won't you have to provide the factory with different eeprom images for the
>    White and Black?  You _trust_ them to get that right, or more likely, you
>    have process control procedures in place so that you don't get 1 million Blacks
>    flashed with the White eeprom image.
> 

I am open to hearing your suggestions for our use case, where the CPU card with
the eeprom is manufactured separately from its carier cards.

I assume you might suggest that manufacturing should (re-)program the EEPROM
on the CPU card after it was inserted into the carrier.

Problem is though that the CPU card may be inserted into ts carrier outside
manufacturing, at the final stages of assembly or in product repair. Those
groups would typically not even have the means to (re-)program the eeprom.
Besides, manufacturing would, quite understandably, go ballistic if we demand
that they start programming EEPROMs after insertion into carrier, and no longer
use pre-programmed EEPROMs.

Note that it is not feasible to put the necessary EEPROM onto the carrier
either. Maybe in a later design. Maybe that makes sense, and we will go along
that route at some point. However, forcing a specific hardware solution
due to software limitations, ie lack of ability by core software to handle
the different carries, seems to be not the right decision to make on an
OS level.

In the PCI world it has long since been accepted that the world is not perfect.  
The argument here is pretty much equivalent to demanding that PCI drop its
quirks mechanism, to force the HW manufacturers to finally get it right from
the beginning. I somehow suspect that this won't happen.

Instead of questioning the need for a mechanism such as the one proposed by
Pantelis, I think our time would be better spent arguing if it is the right
mechanism and, if not, how it can be improved.

Thanks,
Guenter
