From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Tue, 16 May 2017 10:58:20 -0000
Subject: [SPCR] mmio32 iotype access requirements for X-Gene 8250(_dw) UART
In-Reply-To: <7fa523de-3fbb-1566-f521-927143f73d1e@redhat.com>
References: <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <f18738b7096fb06a5865214ddc299ce99630673b.1480644928.git.dhdang@apm.com>
 <6d593615-e97f-8738-42be-1f8f4906d2f4@redhat.com>
 <CADaLNDkyCrheZLNG3_9BVgvGBW8WrA-VPWOCezz3U-g+nt5W9w@mail.gmail.com>
 <175F32B0-C73F-4250-9E60-3CE7409F0B0C@redhat.com>
 <CADaLNDmWRn+UKzF8PH2LmYCSF+NhHaw26RTN+QoaByh1wS7jfQ@mail.gmail.com>
 <7fa523de-3fbb-1566-f521-927143f73d1e@redhat.com>
Message-ID: <20161203171104.GH1115@linaro-xps13.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 03, 2016 at 05:06:31AM -0500, Jon Masters wrote:
> Hi Duc, all,
> 
> (and changing the subject and trimming/adjusting the CC)
> 
> On 12/02/2016 02:39 PM, Duc Dang wrote:
> > On Fri, Dec 2, 2016 at 12:11 AM, Jon Masters <jcm@redhat.com> wrote:
> >> You're welcome.
> >>
> >> (Unrelated) Note that I added a console= and earlycon in my test (and
> >> got the baud rate wrong for the console but nevermind...was ssh'd in
> >> after the earlycon output I cared about anyway) because of some other
> >> cleanup work for the SPCR parsing that apparently is still not quite
> >> fixed for upstream, or rather, there is a need to match on the 32-bit
> >> access required for the UART and that isn't happening so it's not
> >> getting setup. Folks are tracking that one and fixing it though.
> 
> > I don't see this console issue on X-Gene1 (Mustang board). I tried
> > with X-Gene 2 as well. I used both console=ttyS0,115200 and
> > earlycon=uart8250,mmio32,0x1c020000. Are you setting baudrate to
> > 115200 or something else?
> 
> Let me clarify. What I meant above is that when I generated the boot
> log, I had specified earlycon and console parameters, but had fat
> fingered the baud rate (m400 uses 9600, mustang uses 115200 baud).
> That's what I was referring to in the original text above.
> 
> HOWEVER...
> 
> There is a broader problem with X-Gene SPCR support. The problem is
> that the 16550 UART in X-Gene requires the 32-bit access quirk (the
> iotype is set to UPIO_MEM32 for the APMC0D08 device). This means
> that when univ8250_console_match runs later, it will compare the
> iotype (MEM32) with the type previously registered with the
> kernel when the earlycon setup the preferred console.
> 
> The earlycon preferred console will parse the SPCR and find:
> 
>         iotype = table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY ?
>                         "mmio" : "io";
> 
> Which sets it to "mmio" (not "mmio32"). There is a DBG2 (the table
> referenced by the SPCR that provides the actual port types for all
> modern revisions of the SPCR with revision2+, as required by Linux)
> port subtype for non-compliant SBSA ARM Generic UARTs that require
> 32-bit accesses, and this is ACPI_DBG2_ARM_SBSA_32BIT (type 0xd).
> 
> However that only applies for "pl011" devices, and doesn't provide
> for 16550 UARTs that require 32-bit accessors.
> 
> So you'll end up with Linux thinking it's registering a non-32-bit
> mmio preferred console during earlycon setup and then never match
> against that later in the 8250_core/8250_dw match function by
> virtue of the fact that these differ.
> 
> There are a couple of possibilities:
> 
> 1). Perhaps (for some reason) the IP actually does support sub-32-bit
>     access and the iotype simply needs to be changed to reflect this.
>     That would be the easiest option. But it's been this way for a
>     long time in various codebases, so I would be pleasantly
>     surprised if this were the case. Let me/us know :)
> 
> 2). We find some way during SPCR setup to quirk for X-Gene as a non
>     standard 16550 and set it up as an mmio32 iotype.
> 
Aleksey is going to send a patch for review that uses the register width
field in the Generic Address Structure to select mmio vs mmio32 for the
8250 UARTS.

The registers in xgene are 8 bits wide with a padding of 24 dont care
bits, they do allow AFAIK 8 bit address, but they are at 32bit spacing
unlike real 16550 at 8 bit spacing.

> 3). We get the DBG2 table updated to add a subtype of the 16650
>     called something like "(deprecated) 16550 subset supporting
>     only 32-bit accesses". Then we add this to Linux and get
>     the firmware updated on systems to switch to this type. We
>     would probably still want to quirk for existing machines.
> 
> Perhaps I'm missing something. I would love for that to be true,
> but I don't think it is. I think we need a subtype of the 16550
> defined that encapsulates this mmio32 requirement properly. To
> that end, I've preemptively asked some friends at MS for a
> favor to look into adding a new subtype for this.
> 
> Let me know what you think is the best path... :)
> 

I think the new subtype is the way to go as we can also use this to
detect that we have no knowledge of the clocks set by firmware so we
should not attempt a baud rate change like we can on 16550.

Thanks

Graeme
