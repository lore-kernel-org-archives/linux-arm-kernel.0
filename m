From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 17 Oct 2013 13:37:26 -0500
Subject: [PATCH 0/2] Revert support for reserved memory regions defined in
 device tree
In-Reply-To: <1381477716.5630.74.camel@pasglop>
References: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com>
 <1381477716.5630.74.camel@pasglop>
Message-ID: <CAHCPf3s63Jh6YSo2vqJ-4OwfTBGRBcQPAVzw_FK1uU3jpTK+Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 2:48 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2013-10-11 at 09:27 +0200, Marek Szyprowski wrote:
>> Hi all!
>>
>> Benjamin Herrenschmidt pointed a few issues in the proposed design of
>> device tree bindings for contiguous memory allocator and reserved memory
>> regions:
>> https://lkml.org/lkml/2013/9/15/151
>> http://www.spinics.net/lists/arm-kernel/msg273548.html
>
> Are you guys in Edinburgh ?
>
> I'll be there from Tuesday PM (so really Wed) to Friday (fly out on
> Sat). We should catch up, brainstorm and come up with something.
>
> Cheers,
> Ben.

This may be late, but please can you consider re-using the CHRP
reserved node (i.e. device_type = "reserved")?

Since it does exactly the same thing, is well defined since the dark ages?

It's CHRP 1.7 section 5.9 by the way (just before /chosen gets defined).

It would solve a selection of the issues; and require zero binding
work except describing perhaps a couple freakish Linux-specific
properties that may be only as intrusive as, say, linux,initrd would
be in /chosen.

The most effective, multi-OS way of using it ("available" property not
currently implemented in Linux for some reason, but it could come in
so handy - not only because it matches the way Linux resource
structures are handled)

memory at 0x70000000 {
   device_type = "memory";
   reg = <0x70000000 0x40000000>;
   available = <0x70000000 0x10000000
                     0x90000000 0x1ffc00000>; /* top 16KiB of memory
is where the secure firmware keeps it's mailboxes */
};

freaky-codec-memory: reserved at 0x80000000 {
    device_type = "reserved";
    reg = <0x80000000 0x10000000>;
    available = <0x80000000 0x8000000
                      0x88000000 0x8000000>; /* two 128MiB buffers */
    non-objectionable-mark-as-contiguous-property-name-here;
    cacheable;
};

Any driver that has, previously, required a bunch of it's own memory
carved out of DDR *should* be gaining a phandle reference to that
reserved node however it likes (it would be up to that devices'
binding).

On Linux under CMA, it may well be ignored and just stuffed into the
generic CMA regions, and the driver MAY allocate anywhere it likes,
but it COULD ask for memory based on a region phandle or, horribly, by
name (since there's no other way to search for it, the OF "name" for
reserved SHALL be "reserved") and be given memory in that region
defined by the reserved node if it had any addressing restrictions.

/videodecoder at 0x43f01000 {
    compatible = "freaky,codec";
    :
    decode-buffer = &freaky-codec-memory;
};

On another OS it may manually map and use a custom allocator for that
memory region, since otherwise the OS would not have even looked at
it.

Also this discussion of Jeremy Kerr's proposal seems to be 'missing'
on Google. Do you happen to have a link to it?

Thanks,
Matt Sealey <neko@bakuhatsu.net>
