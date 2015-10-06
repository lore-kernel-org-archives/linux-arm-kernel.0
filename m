From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 6 Oct 2015 23:12:51 +0300
Subject: [PATCH v2] ARM: shmobile: silk: add SDHI1 DT support
In-Reply-To: <CANqRtoT40KiX8RQdmCfTu2z4_1H9UH+Kmoe_yOAjZS-hrqssRg@mail.gmail.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
 <20150812012652.GH15957@verge.net.au> <55D790A5.1050008@cogentembedded.com>
 <55D7A3A1.9020009@cogentembedded.com> <20150902022936.GA18115@verge.net.au>
 <55EA2D8D.90004@cogentembedded.com> <20150918002122.GC12858@verge.net.au>
 <CANqRtoSRZo_J1kV0EkYdVzg9YRJ5=Ha3eQRVPKeq9M=kAPLwpA@mail.gmail.com>
 <5601E1F7.1060907@cogentembedded.com>
 <CANqRtoT40KiX8RQdmCfTu2z4_1H9UH+Kmoe_yOAjZS-hrqssRg@mail.gmail.com>
Message-ID: <56142B43.5090800@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Sorry for tyhe long delay, I've been busy with other things. Now I'm 
dealing with SDHI again, this time for the Porter board.

On 09/29/2015 11:44 AM, Magnus Damm wrote:

>>>>>>>>>> Define the SILK board dependent part of the SDHI1 (connected to
>>>>>>>>>> micro-SD slot)
>>>>>>>>>> device nodes along with the necessary voltage regulators.
>>>>>>>>>>
>>>>>>>>>> Based on the original patch by Vladimir Barinov
>>>>>>>>>> <vladimir.barinov@cogentembedded.com>.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>> This patch is against 'renesas-devel-20150810-v4.2-rc6' tag of
>>>>>>>>>> Simon Horman's
>>>>>>>>>> 'renesas.git' repo plus the R8A7794/SILK QSPI patches just
>>>>>>>>>> re-posted. It needs
>>>>>>>>>> the R8A7794 GPIO patches in order to compile.
>>>>>>>>>>
>>>>>>>>>> Changes in version 2:
>>>>>>>>>> - removed not working SDHI0 stuff, renamed the patch;
>>>>>>>>>> - replaced SDHI1's "wp-gpios" property with "disable-wp".
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I am wondering if you could explain the motivation for the
>>>>>>>>> "disable-wp"
>>>>>>>>> update
>>>>>>>>
>>>>>>>>
>>>>>>>>      Please see the comment in mmc_sd_get_ro().
>>>>>>>>
>>>>>>>>> and weather it is appropriate for other r8a779* dts files.
>>>>>>>>
>>>>>>>>
>>>>>>>>      In case of micro-SD slots, yes.
>>>>>>>
>>>>>>>
>>>>>>>      The MMC binding document says it should only be specified if the
>>>>>>> controller has WP detection logic. We, so far, seem to have been
>>>>>>> replying on
>>>>>>> the GPIOs despite this logic is present (according to the R-Car gen2
>>>>>>> SDHI
>>>>>>> manuals I have). The driver will first call mmc_gpio_get_ro() and when
>>>>>>> that
>>>>>>> fails due to "wp-gpios" not being specified, it proceeds to reading
>>>>>>> the
>>>>>>> register but that is forbidden by TMIO_MMC_WRPROTECT_DISABLE flag set
>>>>>>> for
>>>>>>> the R-Car gen1/2 chips, so 0 is always returned from
>>>>>>> tmio_mmc_get_ro().
>>>>>>> There seems to be no point in going that far (and doing the runtime PM
>>>>>>> dances) --
>>>>>
>>>>>
>>>>>      Alternatively, the driver could be fixed to check the flag before
>>>>> the RPM
>>>>> call unlike what it does now.
>>>>
>>>>
>>>> If the driver can be updated to do the right thing then that seems
>>>> preferable to me. If so would it be the case that the presence of the
>>>> "disable-wp" property would not have any run-time effect?
>>>>>
>>>>>
>>>>>>> and MMC_CAP2_NO_WRITE_PROTECT (set when "disable-wp" is specified)
>>>>>>> prohibits
>>>>>>> doing that...
>>>>>>
>>>>>>
>>>>>> That sounds reasonable to me.
>>>>>
>>>>>
>>>>>      I'm still wondering why TMIO_MMC_WRPROTECT_DISABLE is set for the
>>>>> R-Car
>>>>> SoCs. Morimoto-san, any comments? Your change logs are too terse. :-)
>>>>
>>>>
>>>> I will follow up on this.
>>
>>
>> [...]
>>>
>>> Now what is the issue that you guys are having?
>>
>>
>>     My main issue is that I don't understand why checking the write protect
>> bit is always prohibited for the R-Car SoCs (by setting
>> TMIO_MMC_WRPROTECT_DISABLE), i.e. it can only be read via GPIO (though that
>> GPIO is just an alias of the WP signal).

> I believe the reason is that we decided to keep it simple - so we
> preferred to use GPIO instead of native SDHI signals. So GPIO WP
> instead of the not-always-present SDHI WP signal. Historically CD and
> WP may on some boards be routed on different pins than the SDHI CD and
> WP lines, and if we support both GPIO and native SDHI signals we need
> to handle both cases.

    If you look at the driver code, it's already capable of handling both cases.

> With GPIO there is only one case to handle. And
> it is not exactly hot path to handle WP and CD so the overhead must be
> minimal.

[...]

> The on-chip SoC SDHI devices in DT and the driver on R-Car Gen2
> assumes no WP and CD signals by default. It is up to each board to
> opt-in to add the GPIOs for WP and CD. It is very simple and should
> make it possible to power down the SDHI instances if no cards are
> inserted and let the GPIO IRQ wake up things for us.

    Again, if you look at the driver code, it first powers up the controller, 
(thru runtime PM) and only then checks the TMIO_MMC_WRPROTECT_DISABLE flag. 
That's what I tried to change but didn't succeed because the current MMC code 
will have already powered up the controller by that time.

> I still don't understand what the real problem is though...

    The original issue revolved around the "disable-wp" prop. The common MMC 
bindings say that this prop should only be used "when the controller has a 
dedicated write-protect detection logic". This logic is obviously present but 
its use seems suppressed on the R-Car SoCs by the infamous flag... :-)

> Thanks,
>
> / magnus

MBR, Sergei
