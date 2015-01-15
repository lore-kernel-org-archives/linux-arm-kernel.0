From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Jan 2015 18:15:46 +0100
Subject: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
In-Reply-To: <54B73D11.2020905@linaro.org>
References: <548F9668.6080900@linaro.org> <54B5B7B9.6090101@redhat.com>
 <54B73D11.2020905@linaro.org>
Message-ID: <1565137.I9MJ5FjqHu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 January 2015 12:07:45 Hanjun Guo wrote:
> On 2015?01?14? 08:26, Al Stone wrote:
> > On 01/13/2015 10:22 AM, Grant Likely wrote:
> >> On Mon, Jan 12, 2015 at 7:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>> On Monday 12 January 2015 12:00:31 Grant Likely wrote:
> >>>> I've trimmed the specific examples here because I think that misses
> >>>> the point. The point is that regardless of interface (either ACPI or
> >>>> DT) there are always going to be cases where the data needs to change
> >>>> at runtime. Not all platforms will need to change the CPU data, but
> >>>> some will (say for a machine that detects a failed CPU and removes
> >>>> it). Some PCI add-in boards will carry along with them additional data
> >>>> that needs to be inserted into the ACPI namespace or DT. Some
> >>>> platforms will have system level component (ie. non-PCI) that may not
> >>>> always be accessible.
> >>>
> >>> Just to be sure I get this right: do you mean runtime or boot-time
> >>> (re-)configuration for those?
> >>
> >> Both are important.

But only one of the is relevant to the debate of what ACPI offers over
DT. By mixing the two, it's no longer clear which of your examples
are the ones that matter for runtime hotplugging.

> >>>> ACPI has an interface baked in already for tying data changes to
> >>>> events. DT currently needs platform specific support (which we can
> >>>> improve on). I'm not even trying to argue for ACPI over DT in this
> >>>> section, but I included it this document because it is one of the
> >>>> reasons often given for choosing ACPI and I felt it required a more
> >>>> nuanced discussion.
> >>>
> >>> I can definitely see the need for an architected interface for
> >>> dynamic reconfiguration in cases like this, and I think the ACPI
> >>> model actually does this better than the IBM Power hypervisor
> >>> model, I just didn't see the need on servers as opposed to something
> >>> like a laptop docking station to give a more obvious example I know
> >>> from x86.
> >
> > I know of at least one server product (non-ARM) that uses the
> > hot-plugging of CPUs and memory as a key feature, using the
> > ACPI OSPM model.  Essentially, the customer buys a system with
> > a number of slots and pays for filling one or more of them up
> > front.  As the need for capacity increases, CPUs and/or RAM gets
> > enabled; i.e., you have spare capacity that you buy as you need
> > it.  If you use up all the CPUs and RAM you have, you buy more
> > cards, fill the additional slots, and turn on what you need.  This
> > is very akin to the virtual machine model, but done with real hardware
> > instead.

Yes, this is a good example, normally called Capacity-on-Demand (CoD),
and is a feature typically found in enterprise servers, but not in
commodity x86 machines. It would be helpful to hear from someone who
actually plans to do this on ARM, but I get the idea.

> There is another important user case for RAS, systems running critical
> missions such as bank billing system, system like that need high
> reliability that the machine can't be stopped.
> 
> So when error happened on hardware including CPU/memory DIMM on such
> machines, we need to replace them at run-time.
>
> > Whether or not this product is still being sold, I do not know.  I
> > have not worked for that company for eight years, and they were just
> > coming out as I left.  Regardless, this sort of hot-plug does make
> > sense in the server world, and has been used in shipping products.
> 
> I think it still will be, Linux developers put lots of effort to
> enable memory hotplug and computer node hotplug in the kernel [1], and
> the code already merged into mainline.
> 
> [1]:
> http://events.linuxfoundation.org/sites/events/files/lcjp13_chen.pdf

The case of memory hotremove is interesting as well, but it has some
very significant limitations, regarding system integrity after
uncorrectable memory errors as well as nonmovable pages.  The cases
I know either only support hot-add for CoD (see above), or they support
hot-replace for mirrored memory only, but that does not require any
interaction with the OS.

Thanks for the examples!

	Arnd
