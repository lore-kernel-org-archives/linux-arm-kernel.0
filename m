From: dianders@chromium.org (Doug Anderson)
Date: Wed, 23 Apr 2014 09:35:30 -0700
Subject: [PATCH v2 0/7] Add cros_ec changes for newer boards
In-Reply-To: <CAD=FV=XbjeOR+A-ZVYgOT69gsdp-YrjbkGrjL2Vf4F31ZkGXTA@mail.gmail.com>
References: <1398185154-19404-1-git-send-email-dianders@chromium.org>
 <20140423123240.GA640@lee--X1> <5357E832.1000806@wwwdotorg.org>
 <CAD=FV=XbjeOR+A-ZVYgOT69gsdp-YrjbkGrjL2Vf4F31ZkGXTA@mail.gmail.com>
Message-ID: <CAD=FV=UWnLLzqzmrt0z=38iDOBSRJJLNAG8PL0GSHt1758ACcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 23, 2014 at 9:32 AM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Wed, Apr 23, 2014 at 9:20 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 04/23/2014 06:32 AM, Lee Jones wrote:
>>> On Tue, 22 Apr 2014, Doug Anderson wrote:
>>>
>>>> This series adds the most critical cros_ec changes for newer boards
>>>> using cros_ec.  Specifically:
>>>> * Fixes timing/locking issues with the previously upstreamed (but
>>>>   never used upstream) cros_ec_spi driver.
>>>> * Updates the cros_ec header file to the latest version which allows
>>>>   us to use newer EC features like i2c tunneling.
>>>> * Adds an i2c tunnel driver to allow communication to the EC's i2c
>>>>   devices.
>>>>
>>>> This _doesn't_ get the EC driver fully up to speed with what's in the
>>>> current Chromium OS trees.  There are a whole slew of cleanup patches
>>>> there, an addition of an LPC transport mode, and exports of functions
>>>> to userspace.  Once these patches land and we have functionality we
>>>> can continue to pick more cleanup patches.
>> ...
>>> Need to wait for the ARM, DT and I2C guys to review, at which point
>>> I'll be happy to take in and supply a branch for them to pull from if
>>> required. If there are no _true_ dependencies and the MFD changes can
>>> be added independently without fear of build breakages, let me know
>>> and I'll apply them separately.
>>
>> I believe there aren't direct dependencies between the patches. So, the
>> MFD patches can be applied to the MFD tree and the DT patch applied to
>> the Tegra tree. I'm simply waiting for the MFD patches to be applied
>> before applying the DT patch so that I know the DT binding definition is
>> fully accepted before applying a patch that uses it.
>
> All of the MFD patches are safe to apply and in pretty much arbitrary
> order.  The strong dependencies in the chain are:
>
> * We need patch #5 (mfd: cros_ec: Sync to the latest
> cros_ec_commands.h from EC sources) before the i2c tunnel can compile.
>
> * As Stephen says, he shouldn't apply the device tree until we're
> confident that the bindings are right.  However there's no strong
> dependency otherwise.
>
> * Patches #1 #2 and #3 are simply reliability fixes.  Those could land
> at any point in time and will improve other users of cros_ec_spi (like
> the keyboard on tegra124-venice2).
>
> * Patch #4 can apply any time with no issues.  Without it large i2c
> tunnel transfers won't work, but that's not a terrible problem (all
> normal transfers are small).
>
> ---
>
> All that being said, I'd request that you merge patches #1-#4 as soon
> as you can and make sure you can provide a way that Wolfram can pull
> them (or at least patch #4) into his i2c tree to keep them applying
> when he is ready to land #5.

Oops, I missed a patch.  Let me say that again.

Patch #5 (latest ec commands) can also apply at any time with no
issues, but it's needed for patch #6 (the tunnel) to compile.

All that being said, I'd request that you merge patches #1-#5 as soon
as you can and make sure you can provide a way that Wolfram can pull
them (or at least patch #5) into his i2c tree to keep them applying
when he is ready to land #6.
