From: joel@jms.id.au (Joel Stanley)
Date: Thu, 17 Nov 2016 20:33:27 +1030
Subject: [RFC PATCH] mfd: dt: Add Aspeed LPC binding
In-Reply-To: <4751029.AudB7s5avo@wuerfel>
References: <20161117060633.3837-1-andrew@aj.id.au>
 <4751029.AudB7s5avo@wuerfel>
Message-ID: <CACPK8Xf=f=9Zw=jf0K+RemSdmUiCMgvFuGgKGtB=v8_4b1r6iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 7:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday, November 17, 2016 4:36:33 PM CET Andrew Jeffery wrote:
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> ---
>>
>> I'd like to start a discussion about how to handle the LPC register space in
>> the Aspeed SoC. There are a number of issues, largely concerned with the layout
>> of the registers but also with the fact that LPC register state is used by the
>> pinmux to determine some pin functionality.
> ...
>>
>> What is the recommended approach to managing such hardware?
>
> Can you clarify which side of the LPC bus this is? We are currently having
> a discussion for how to integrate the LPC master on an ARM64 server that
> uses LPC to access an Aspeed LPC slave. For this one we want to use the
> traditional ISA DT binding.

This is from the perspective of the BMC.

On the machines we are talking to, most (all?) access is performed
through the system firmware (skiboot).

> I'm guessing that you are interesting in the other side here, for mapping
> the registers of the LPC slave on the Aspeed BMC, but that's not clear from
> your email, as I'm assuming that the same chip has both master and slave
> interfaces.

Yep, we come from the "other side".

The BMC itself can operate the bus in Master or Slave mode. We are
interested in the slave case, for when the host is requesting access
to its system firmware at boot time.  This happens by mapping a region
of the BMC's AHB memory space into the LPC address space. After we
deal with pinmux, Andrew or I will be hacking on a driver to configure
that space, as the BMC needs to configure the window before the host
can boot. It's a pile of bits spread out over different parts of the
chip, and doesn't map nicely into any existing driver model we have in
the kernel.

Other functions include IPMI communication between the BMC and the
host via the LPC bus via the iBT interface. We have a driver for that
staged for 4.10. Then there's a mailbox, some "scratch" registers that
can be used by the firmware for whatever they see fit, and all kinds
of crazy legacy x86 stuff like POST code registers.

Cheers,

Joel
