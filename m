From: Hollis_Blanchard@mentor.com (Blanchard, Hollis)
Date: Mon, 14 Feb 2011 15:05:00 -0800
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <AANLkTin+ZSNHX2iv=XwWCgxy330UJwhkf1T=4BMXZ22s@mail.gmail.com>
References: <4D55A7F7.5090700@mentor.com>
	<AANLkTin+ZSNHX2iv=XwWCgxy330UJwhkf1T=4BMXZ22s@mail.gmail.com>
Message-ID: <DD7A9A95166BF4418C4C1EB2033B6EE2038FAADB@na3-mail.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2011 01:24 PM, Linus Walleij wrote:
>> >      3. Userspace interfaces for accessing the mailboxes.  A
>> >         '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.
> What kind of business does userspace have with directly using
> mailboxes? Enlighten me so I get it... in our system these are
> used by protocols, such as net/caif/* thru drivers/net/caif/*, and
> we have similar kernelspace functionality for Phonet.
>
> CAIF and Phonet on the other hand, have custom openings
> down to the thing that exists on the other end of the mailbox.
> Most of these systems tend to talk some funny protocol that
> is often better handled by the kernel than by any userspace.
>
> So is this for the situation when you have no intermediate
> protocol between your userpace and the other CPU's
> subsystem? Or are you thinking about handling that
> protocol in userspace? That is generally not such a good idea
> for efficiency reasons.
OpenMCAPI (http://openmcapi.org) implements the MCAPI specification, 
which is a simple application-level communication API that uses shared 
memory. The API could be layered over any protocol, but was more or less 
designed for simple shared-memory systems, e.g. fixed topology, no 
retransmission, etc.

Currently, we implement almost all of this as a shared library, plus a 
very small kernel driver. The only requirements on the kernel are to 
allow userspace to map the shared memory area, and provide an IPI 
mechanism (and allow the process to sleep while waiting). Applications 
sync with each other using normal atomic memory operations.

We're now trying to optimize the transfer of scalars on platforms that 
provide mailboxes (beyond simple IPIs), which is why we're looking at 
defining a user-facing API to such hardware.

I'll add that we haven't done serious optimization yet, but the numbers 
we do have seem reasonable. What are the "efficiency" issues you're 
worried about?

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
