From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 10 Aug 2010 08:34:18 -0700
Subject: [PATCH v3] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <4C616C7F.3060206@criticallink.com> (Michael Williamson's message
	of "Tue, 10 Aug 2010 11:13:03 -0400")
References: <4C45AE5E.7070905@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7D0AF64@dbde02.ent.ti.com>
	<4C4D8449.9040706@criticallink.com>
	<87mxt0ubnr.fsf@deeprootsystems.com>
	<4C5B1378.7080400@criticallink.com>
	<AANLkTik1Z1mromdUMK0Qf9iC9tude_4=4XgsL7A-x+K7@mail.gmail.com>
	<4C5B1B6C.2040601@criticallink.com>
	<87r5i68rsp.fsf@deeprootsystems.com>
	<4C616C7F.3060206@criticallink.com>
Message-ID: <8762zi7a85.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

>  On 8/10/2010 10:29 AM, Kevin Hilman wrote:
>

[...]

>>
>> I would advise using the ATAG_REVISION for basic setup, but consider
>> using/expanding the command-line options for specific drivers.
>>
>
> Looks like ATAG_REVISION is going to be (at least partially) consumed by the
> patch Sekhar is working on here:
>
> https://patchwork.kernel.org/patch/110577/
>
> I think the problem I have is that we need to support multiple boards
> using the developed SOM.  The SOM in and of itself does not define a
> "board".  It has to be paired with a host board.
>
> I had thought there would be a way to avoid generation of multiple board
> files that only differed in the chip peripheral instantiation /
> configuration.  With the powerpc architecture, the device tree allowed
> instantiation and configuration of SOC peripherals at load/runtime.  I
> don't see anything like that capability in the ARM architecture.  

The good news is that there is active work for device tree support for
ARM.  The bad news is that it is still a ways from being ready.

> The command line options might work, but I expect that they would
> rapidly devolve into hacks.
>
> The patch that has been put forth to read additional board information (MAC

> address, etc.) from a SPI NOR device during the MTD probe phase (link below)
> might work, but it requires that the SPI and the MTD drivers are working
> well enough to read this data out.  Not helpful if you want to be able
> to configure the SPI at startup (add additional chip selects, etc.)

Another possible option is to use ATAG_REVISION to do the absolute
minimal setup so you can get to from non-volatile storage.  In your
case, the minimum is probably SPI chipselect (and UART for debug.)
After that, the config for all the other peripherals could be flashed.

> https://patchwork.kernel.org/patch/118530/
>
> I think I need to withdraw this submission.  We can't afford to
> maintain the board files for the number of host boards that are already
> being developed, and there's no way we could get them all issued to
> the mainline.

I agree, having to maintain a large number of minimally different board
files is not a good solution either.

> There don't appear to be any instances of non-EVM type boards in
> mach-davinci (at least for the da850), so my guess is other users of
> this SOC have come to the same conclusion.

Possibly, but from what I see and hear, it's more likely that most other
users have not been as interested in getting support for their boards
upstream.  Thanks for putting in the extra effort to try.  

If you're willing to give it another spin, I still think it's possible
to get what you would need with the "hybrid" solution of using
ATAG_REVISION for minimal setup, and getting the rest from flash.

Kevin
