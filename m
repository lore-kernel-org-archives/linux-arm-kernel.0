From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 14 Nov 2016 20:25:36 -0700
Subject: [PATCH 3/4] fpga mgr: zynq: Add support for encrypted bitstreams
In-Reply-To: <alpine.DEB.2.10.1611142022380.6582@atull-VirtualBox>
References: <20161107001326.7395-1-moritz.fischer@ettus.com>
 <20161107001326.7395-4-moritz.fischer@ettus.com>
 <alpine.DEB.2.10.1611142022380.6582@atull-VirtualBox>
Message-ID: <CAAtXAHepvE1nzR44GY9kXv9ue-Un34LaHxDm5B35ecf35LayBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Mon, Nov 14, 2016 at 7:42 PM, atull <atull@opensource.altera.com> wrote:
> On Mon, 7 Nov 2016, Moritz Fischer wrote:
>
> Hi Moritz,
>
> This looks good.  Probably the socfpga changes could get
> folded into this patch (was patch 4/4) unless you thought of
> a reason not to (after that patch is changed to see if the
> MSEL bits are set to enable decrypt).

Yeah. Agreed. I had kept that one separate because i was less
sure on how the socfpga stuff works. Will merge it together for
next revision.

>
> There also could be a uncompress cap as well since cyclone 5
> supports both compressed and encrypted images and has bits
> in the MSEL for them (I mentioned separately in my comments
> about patch 4/4).

Ok.
>
> For the Zynq, does the encrypt bit denote a requirement that
> the part will only take an encrypted image or is it an
> option that it supports?  IIRC (and my brain is currently
> pretty tired), if the MSEL for Cyclone5 is set for
> encryption, the bitsream must be encrypted (same for
> compress).  That might change the meaning of this stuff a
> bit but probably doesn't necessitate a change in the
> implementation.  It also makes the sysfs that much more
> useful as it allows the users to know what type of image
> they are required to provide.

I don't think that's the case for Zynq. I think the actual reason for
different behavior is the fact that the AES unit now takes the
bitstream bytewise vs 4 bytes at a time, which is why the clock
needs to be divided by four. The TRM isn't overly specific on that.
I Will take another look in the Zynq 7000 TRM.

I do agree that the sysfs interface becomes more useful if
having an encrypted bitstream or compressed bitstream is now
mandatory. I'll need to think about this some more. Maybe to
make this useful there needs to be a distinction between
mandatory and optional capabilities. One could model it by
adding a PLAIN vs CRYPTED capability ... mhhh

Thanks for the review,

Moritz
