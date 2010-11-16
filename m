From: victor.rodriguez@sasken.com (Victor Rodriguez)
Date: Wed, 17 Nov 2010 02:49:42 +0530
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <4CE2ECCD.8090603@criticallink.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
	<1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ABE7@dbde02.ent.ti.com>
	<4CE124AE.4080301@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ACE1@dbde02.ent.ti.com>
	<4CE1560F.6080705@mvista.com>
	<AANLkTimDpYrx_OWg7ABXqRJ5JYzhpVbbyzVMhmFD6Wxi@mail.gmail.com>
	<4CE2AB73.3050109@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234ADA4BC@dbde02.ent.ti.com>,
	<4CE2ECCD.8090603@criticallink.com>
Message-ID: <000B6D2ED51BF34B97DCBD9D3AF639C601888A318F50@EXGMBX01.sasken.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


________________________________________
From: Michael Williamson [michael.williamson at criticallink.com]
Sent: Tuesday, November 16, 2010 2:42 PM
To: Nori, Sekhar
Cc: Sergei Shtylyov; Victor Rodriguez; davinci-linux-open-source at linux.davincidsp.com; Russell King; Victor Rodriguez; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard

On 11/16/2010 11:37 AM, Nori, Sekhar wrote:

> On Tue, Nov 16, 2010 at 21:34:03, Sergei Shtylyov wrote:
>
>>
>>> HI Sergei and Sekhar
>>
>>> Thanks for check the patch
>>
>>> What I can do if you agree with this change is to leave da850.c as it
>>> is,
>>
>>     No, please don't.
>>
>>> and declare
>>
>>> static short hawk_mcasp_pins[] __initdata = {
>>>     DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
>>>     DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
>>>     DA850_AXR_11, DA850_AXR_12, DA850_AXR_13, DA850_AXR_14,
>>>     -1
>>> };
>>
>>> on the hawkboard file and call it insted of da850_mcasp_pins.
>>
>>>     ret = davinci_cfg_reg_list(hawk_mcasp_pins);
>>>     if (ret)
>>>             pr_warning("%s: mcasp mux setup failed: %d\n", __func__, ret);
>>
>>> Please tell me if you agree with this change, I think is better
>>> because I do not touch any other file besides my board file.
>>
>>     No, it's not really better. The generic list in da850.c should be more
>> complete, regardless... Ideally, you should go thru the DA850 manual and put in
>> that list all McASP pins that aren't already there. Then you can use your own
>> pin list if that *complete* pin list can't be used on your board.
>
> That will cause a bunch of pin conflicts on the EVM so it will need
> its own list too.
>


Help me out.  Why do we need generic pin lists?

It seems to me that the "generic pin list" for da850.c isn't practical for most
(if not all) of the peripherals.  They should be done using __initdata in
each board file.

Just a cursory glance at what's in da850.c highlights several items being set
up for the EVM and not generically.  For example:

- da850_uart1_pins and da850_uart2_pins: I believe both have RTS/CTS pins which
  for a generic definition should be included as for UART0, but would then
  be unused as the EVM doesn't use these pins in this function.

- da850_mcasp_pins: if generic, must include all 16 AXR pins.  I think you'd
  be hard pressed to find a board configuration that would use all 16 AXR pins
  for the McASP.  I'm fairly sure the EVM uses the pins called out, and uses
  other pins for other functions.  So it's likely this structure wouldn't get used.

- da850_mmcsd0_pins : includes 2 GPIO pins (specific to the EVM, though possible for
  other boards) for the card detect and write protect signals.  These pins are
  completely arbitrary for that particular board design. I also believe that
  the complete mmcsd0 port has 4 more data lines as part of it's peripheral, although
  the driver doesn't support using them.

- da850_emif25_pins interface doesn't include the generic pins for some of
  the SDRAM functions.

- da850_cpgmac_pins defines both RMII and MII pins.  I don't think any board
  would want to configure both sets at the same time.  Seems like this should
  never get used...

It's also incomplete.  What about the uPP pin list?  Or the VPIF?  Etc.

I think a board file author should be familiar enough with the SoC to understand
what peripheral pins he should be configuring for his/her particular hardware setup
and explicitly specify them in the board file.

If you remove the common pin-mux lists and move them to a board file, then once you
configure your specific platform, is there any more memory used than with
the common scheme?  Of course, there would be replication of pin-mux code in the board
files that had identical configurations.  Is that the driver for the current implementation?

Is there a thread that hashes through the decisions on this that I should be googling?

Thanks for any insight.

-Mike


Hi Mike thanks for the comments I agree with the part of replication

So do you recommend that the best way to solve this problem is to make a  pin list that has all the 16 pins on da850.c ?

I have checked and on the file

arch/arm/mach-davinci/include/mach/mux.h

are declared

        /* McASP function */
        DA850_ACLKR,
        DA850_ACLKX,
        DA850_AFSR,
        DA850_AFSX,
        DA850_AHCLKR,
        DA850_AHCLKX,
        DA850_AMUTE,
        DA850_AXR_15,
        DA850_AXR_14,
        DA850_AXR_13,
        DA850_AXR_12,
        DA850_AXR_11,
        DA850_AXR_10,
        DA850_AXR_9,
        DA850_AXR_8,
        DA850_AXR_7,
        DA850_AXR_6,
        DA850_AXR_5,
        DA850_AXR_4,
        DA850_AXR_3,
        DA850_AXR_2,
        DA850_AXR_1,
        DA850_AXR_0,

I have changed the pin list to


const short da850_mcasp_pins[] __initdata = {
        DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
        DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
        DA850_AXR_11, DA850_AXR_12,DA850_AXR_13, DA850_AXR_14, DA850_AXR_15,
        -1
};

and after checked with the hawk board it works fine

I have put on the list all the available pins for McASP even if hawkboard does not need the last one DA850_AXR_15 , and is still working

Please tell me which way do you recommend me

Regards

Victor Rodriguez




SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
