From: keshava_mgowda@ti.com (Munegowda, Keshava)
Date: Mon, 2 Jul 2012 12:06:08 +0530
Subject: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix
 issues.
In-Reply-To: <Pine.LNX.4.44L0.1206291104270.1638-100000@iolanthe.rowland.org>
References: <1340848783-9480-1-git-send-email-Russ.Dill@ti.com>
 <Pine.LNX.4.44L0.1206291104270.1638-100000@iolanthe.rowland.org>
Message-ID: <CAP05o4+NhGgmZkUymmKEGY9szrot6ND_3oDedbMHpc_+sW0HHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 9:03 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 27 Jun 2012, Russ Dill wrote:
>
>> From: Russ Dill <Russ.Dill@gmail.com>
>>
>> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0) fixes
>> an issue where the ULPI PHYs were not held in reset while initializing
>> the EHCI controller. However, it also changes behavior in
>> omap-usb-host.c omap_usbhs_init by releasing reset while the
>> configuration in that function was done.
>>
>> This change caused a regression on BB-xM where USB would not function
>> if 'usb start' had been run from u-boot before booting. A change was
>> made to release reset a little bit earlier which fixed the issue on
>> BB-xM and did not cause any regressions on 3430 sdp, the board for
>> which the fix was originally made.
>>
>> This new fix, 'USB: EHCI: OMAP: Finish ehci omap phy reset cycle
>> before adding hcd.', (3aa2ae74) caused a regression on OMAP5.
>>
>> The original fix to hold the EHCI controller in reset during
>> initialization was correct, however it appears that changing
>> omap_usbhs_init to not hold the PHYs in reset during it's
>> configuration was incorrect. This patch first reverts both fixes, and
>> then changes ehci_hcd_omap_probe in ehci-omap.c to hold the PHYs in
>> reset as the original patch had done. It also is sure to incorporate
>> the _cansleep change that has been made in the meantime.
>>
>> Tested on Beagleboard xM.
>
> Looking at the result of this patch, there seem to be a few mistakes
> remaining in the probe routine.
>
> If the regulator_get() call fails, the failure is logged but ignored.
> Is that really the right thing to do?
>
> The pm_runtime_get_sync() call occurs before the probe is finished.
> This means that ehci-hcd's resume routine will try to power-up the
> device before its data structures have been initialized.  That can't be
> right.
>
> The "get clocks" section occurs after the call to usb_add_hcd().  This
> means the controller will start running before the clock references are
> acquired -- so the clocks might still be turned off.  That can't be
> right either.
>
> If the clk_get(dev, "utmi_p1_gfclk") call fails, the error path never
> calls usb_remove_hcd().
>
> The "err_add_hcd" pathway never calls usb_put_hcd().
>
> I'm going to resubmit my most recent patch based the current
> ehci-omap.c, but you or someone else will still have to fix these
> problems.
>
> Alan Stern
>

Hi Rus Dill,
    once Alan post his changes on ehci-omap.c, please re-base this
patch on top of it.
so that, I will rebase UHH-TLL split series on top your patch.

regards
keshava
