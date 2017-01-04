From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Jan 2017 13:23:41 +0100 (CET)
Subject: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
In-Reply-To: <20170104121425.GP14217@n2100.armlinux.org.uk>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
 <20170102140654.GF14217@n2100.armlinux.org.uk>
 <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
 <20170103213118.GM14217@n2100.armlinux.org.uk>
 <20170103215421.GN14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041155380.3073@hadrien>
 <20170104110750.dtu54t74qkuuvkvq@piout.net>
 <alpine.DEB.2.20.1701041242080.3073@hadrien>
 <20170104121425.GP14217@n2100.armlinux.org.uk>
Message-ID: <alpine.DEB.2.20.1701041320140.3073@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 4 Jan 2017, Russell King - ARM Linux wrote:

> On Wed, Jan 04, 2017 at 12:43:32PM +0100, Julia Lawall wrote:
> > > The question was whether the point to the rtc_class_ops could be made
> > > __ro_after_init. And Russell is right, it is pointed to by the ops
> > > pointer in a struct rtc_device and that struct is dynamically allocated
> > > in rtc_device_register().
> >
> > OK, I think it's a terminology issue.  You mean the structure that
> > contains the pointer, and not the pointer itself, which is already const.
>
> That statement is really ambiguous, and really doesn't help the cause -
> we have several structures here which contain pointers and it's far from
> clear which you're talking about:
>
> - The armada38x_rtc_ops and armada38x_rtc_ops_noirq structures contain
>   pointers to functions.
> - The dynamically allocated struct rtc_device contains an ops pointer,
>   which will point at one or other of these two structures.
>
> Now, as soon as we make armada38x_rtc_ops and armada38x_rtc_ops_noirq
> const, if the pointer is passed through any function call where the
> argument is not also marked const, or is assigned to a pointer that is
> not marked const (without an explicit cast), the compiler will complain.
> Remember that a const pointer (iow, const void *ptr) is just a hint to
> the compiler that "ptr" _may_ point at read-only data, and dereferences
> of the pointer are not allowed to write - it's just syntactic checking.
>
> Given that this is stuff we should all know, I'm not quite sure what
> people are getting in a tiz over... I'm finding it worrying that I'm
> even writing this mail, reviewing this stuff!  _Really_ worried that
> Kees even brought it up in the first place - I suspect that came from
> a misunderstanding of my suggestion which is why I later provided the
> suggestion in patch form.
>
> What I suggested, and what my patch does is:
>
> 1. It places both the armada38x_rtc_ops and armada38x_rtc_ops_noirq
>    structures into the .rodata section, which will be protected from
>    writes by hardware when appropriate kernel options are enabled.
>
> 2. The driver does _not_ store a local pointer to this memory at a
>    static address which could be subsequently modified (*).
>
> 3. The only pointer to this memory is during driver initialisation
>    (which may well reside in a CPU register only) before being passed
>    to the RTC subsystem.
>
> 4. The RTC subsystem dynamically allocates a struct rtc_device
>    structure (in rtc_device_register()) where it eventually stores
>    this pointer.  This pointer is already marked const.  This structure
>    contains read/write data, and can't be marked read-only, just in the
>    same way as "struct file" can't be.
>
> The whole __ro_after_init thing is completely irrelevant and a total
> distraction at this point - there is nothing that you could add a
> __ro_after_init annotation to after my patch in regard of these ops
> structures.
>
> * - however, a compiler may decide to store the addresses of these
> structures as a literal constant near the function, but with RONX
> protection for the .text section, this memory is also read-only, and
> so can't be modified.

Thanks for the explanation.  I understood the patch, just not Kees's
question.

Basically, the strategy of the patch is that one may consider it
preferable to duplicate the structure for the different alternatives,
rather than use __ro_after_init.  Perhaps if the structure were larger,
then __ro_after_init would be a better choice?

thanks,
julia
