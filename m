From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Tue, 26 Nov 2013 23:32:25 +0000
Subject: ACPI
In-Reply-To: <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
 <20131125154110.GB3243@srcf.ucam.org>
 <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
 <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
 <20131126183344.GA16074@srcf.ucam.org>
 <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
Message-ID: <20131126233224.GA21189@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 05:11:23PM -0600, Matt Sealey wrote:

> Before stabbing around adding ACPI and then having DT-in-ACPI isn't
> there a use case for an an ARM Linux kernel actually being a good
> citizen of UEFI?

That's work in progress. Patches have been posted and are getting pretty 
close to being mergeable. You can already run VExpress with UEFI.

> Having UEFI pass along the DT as a configuration table as well as ACPI
> tables should be the first order of business. It needn't be
> DT-specific either - there's no reason that specific configuration
> table can't define a thousand ways to boot Linux on ARM. But one or
> two might be better for the sanity of the Linux kernel guys. In fact,
> because UEFI hands information in the early boot process to the
> 'application' (being the kernel), and has a very well defined API, it
> would remove the need for weird out of band stuff like /memreserve/
> entries in the DT and simplify and make the Linux early boot process
> more robust and debuggable.

Passing both is somewhat problematic - if one is supposed to be 
sufficient, why pass the other? It'd be pretty easy to end up with skew 
between them, and unless we're clear on what happens in the event of 
conflicting information then it's going to end badly.

> 1) Existing code is around that drives certain logic common on a bunch
> of server boards and nobody wants to write drivers for them *again*,
> especially since there is a distinct advantage to hidin^H^H^H^H^H
> abstracting the actual implementation from Linux (fan controllers etc.
> could be done in hundreds of different ways) in terms of product
> safety, product reliability, and kernel stability for companies like
> Red Hat.

Servers rarely use ACPI for thermal control, but yeah, I take your 
point.

> 2) Because you can do fancy 'scripting' as well as bus and device
> configuration abstraction on top of description.

Sure.

> 3) Because there seems to be an absolutely moronic assumption that the
> best way to get an ARMv8 server box on the market is take an existing
> server design and just drop an ARM SoC into it and the above existing
> code should "drop in" in that case.

Well, so far we had any indication as to whether or not anyone's 
planning on doing that. I suspect it could be made to work, the question 
is how invasive the kernel changes would be.

> But I can't think of a reason why an extension or companion to PSCI
> couldn't do it, and why you WOULDN'T want to do this as an API
> implemented via a secure monitor interface which is architecturally
> defined on ARM where security extensions are present. I can't imagine
> a reason why it couldn't be done over IPMI to some microcontroller or
> dedicated external component, for the case of fans and chassis
> components and tedious other stuff.

Primarily because people want solutions that aren't tied to having an 
entirely separate computer running its own embedded OS. The likely 
alternative to doing things in ACPI would be to do them in TrustZone, 
and let's not encourage that. A significant proportion of the bugs we 
see on x86 are down to SMM code that we can't see, let alone debug. It's 
much easier to handle bugs in code that runs in the same context as the 
OS.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
