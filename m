From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 2 Dec 2014 11:06:18 -0800
Subject: [PATCH V6 05/12] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <20141202094741.GC6135@ulmo>
References: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
 <1416874644-12070-6-git-send-email-abrestic@chromium.org>
 <20141202094741.GC6135@ulmo>
Message-ID: <CAL1qeaEN8HjGYyW0+WLyEUzSPgCKiQUo0jRbbsY1rsfamijA3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 2, 2014 at 1:47 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Nov 24, 2014 at 04:17:17PM -0800, Andrew Bresticker wrote:
>> The Tegra xHCI controller's firmware communicates requests to the host
>> processor through a mailbox interface.  While there is only a single
>> physical channel, messages sent by the controller can be divided
>> into two groups: those intended for the PHY driver and those intended
>> for the host-controller driver.  The requesting driver is assigned
>> one of two virtual channels when the single physical channel is
>> requested.  All incoming messages are sent to both virtual channels.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Thierry,
>>
>> I've left this as a separate driver because I don't think it should be
>> combined with the xHCI host.  Stephen and I discussed this earlier in
>> review of v1 of this series and he agreed that the mailbox belongs in
>> its own DT node and driver.
>
> My objection wasn't strictly against merging the drivers. What I don't
> want to see is two devices sharing the same memory-mapped regions in DT.
>
> That's based on earlier discussion with Stephen as well, because we have
> had the same problem with USB and USB-PHY before. Unless I completely
> misinterpreted we came to the conclusion that we should avoid this in
> the future.

Yes, I understand your objection to having multiple drivers map the
same IO memory, however Stephen and I discussed this before [1] and
came to the conclusion that, although mapping the MMIO region in both
drivers was non-ideal, the alternatives had their own drawbacks as
well and that the approach I had taken was fine.

> Like I said, this doesn't mean that both need to be in the same driver.
> We could use MFD for example, or provide an entry point in the mailbox
> driver that can be called from the XUSB driver to instantiate the
> mailbox (which is really the same as MFD).

This does not look like the typical MFD, but I would agree that it's
the only reasonable alternative.  If Lee is fine with it, then I
suppose I could go the MFD route...  Lee: for context, the mailbox
registers live in one of the host-controller's MMIO regions - there
are no other shared resources.  This has been discussed, along with a
possible binding, in [1] as well.

[1] https://lkml.org/lkml/2014/8/27/727
