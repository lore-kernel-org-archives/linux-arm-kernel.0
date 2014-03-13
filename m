From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Thu, 13 Mar 2014 17:21:09 +0000
Subject: [RFC PATCH] edac: zynq: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <53209047.8070308@xilinx.com>
References: <4adb2b4b-2ad6-42b9-929e-cc062f817245@TX2EHSMHS021.ehs.local>
 <20140310105655.GH14999@e106331-lin.cambridge.arm.com>
 <531DA900.5060202@monstr.eu>
 <fa35006e-055d-4ef2-9b65-a0f8cc6a0c8f@AM1EHSMHS016.ehs.local>
 <531ECA33.8050803@monstr.eu> <20140311155057.GJ13293@xsjandreislx>
 <c7840b9d-4c03-4680-9a0e-fb256f3743b4@AM1EHSMHS010.ehs.local>
 <20140312161344.GA3000@xsjandreislx> <53209047.8070308@xilinx.com>
Message-ID: <5c399e76-42e4-4f8e-852e-91d88b229ae7@TX2EHSMHS006.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Michal Simek [mailto:michal.simek at xilinx.com]
>Sent: Wednesday, March 12, 2014 10:20 PM
>To: Soren Brinkmann
>Cc: Michal Simek; monstr at monstr.eu; Mark Rutland; Punnaiah Choudary
>Kalluri; dougthompson at xmission.com; devicetree at vger.kernel.org; linux-
>doc at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>kernel at vger.kernel.org; linux-edac at vger.kernel.org; robh+dt at kernel.org;
>Pawel Moll; ijc+devicetree at hellion.org.uk; galak at codeaurora.org;
>rob at landley.net; kpc528 at gmail.com; kalluripunnaiahchoudary at gmail.com;
>Punnaiah Choudary Kalluri
>Subject: Re: [RFC PATCH] edac: zynq: Added EDAC support for zynq ddr ecc
>controller
>
>On 03/12/2014 05:13 PM, S?ren Brinkmann wrote:
>> On Wed, 2014-03-12 at 11:27AM +0100, Michal Simek wrote:
>>> On 03/11/2014 04:50 PM, S?ren Brinkmann wrote:
>>>> On Tue, 2014-03-11 at 09:32AM +0100, Michal Simek wrote:
>>>>> On 03/10/2014 11:32 PM, S?ren Brinkmann wrote:
>>>>>> On Mon, 2014-03-10 at 12:58PM +0100, Michal Simek wrote:
>>>>>>> On 03/10/2014 11:56 AM, Mark Rutland wrote:
>>>>>>>> On Sun, Mar 09, 2014 at 02:57:16AM +0000, Punnaiah Choudary
>Kalluri wrote:
>>>>>>>>> Added EDAC support for reporting the ecc errors of zynq ddr
>controller.
>>>>>>>>> The ddr ecc controller corrects single bit errors and detects double
>bit
>>>>>>>>> errors
>>>>>>>>>
>>>>>>>>> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
>>>>>>>>> ---
>>>>>>>>>  .../devicetree/bindings/edac/zynq_edac.txt         |   18 +
>>>>>>>>>  drivers/edac/Kconfig                               |    7 +
>>>>>>>>>  drivers/edac/Makefile                              |    1 +
>>>>>>>>>  drivers/edac/zynq_edac.c                           |  613
>++++++++++++++++++++
>>>>>>>>>  4 files changed, 639 insertions(+), 0 deletions(-)
>>>>>>>>>  create mode 100644
>Documentation/devicetree/bindings/edac/zynq_edac.txt
>>>>>>>>>  create mode 100644 drivers/edac/zynq_edac.c
>>>>>>>>>
>>>>>>>>> diff --git
>a/Documentation/devicetree/bindings/edac/zynq_edac.txt
>b/Documentation/devicetree/bindings/edac/zynq_edac.txt
>>>>>>>>> new file mode 100644
>>>>>>>>> index 0000000..c21ff83
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/Documentation/devicetree/bindings/edac/zynq_edac.txt
>>>>>>>>> @@ -0,0 +1,18 @@
>>>>>>>>> +Zynq EDAC driver, it does reports the DDR ECC single bit errors
>that are
>>>>>>>>> +corrected and double bit ecc errors that are detected by the DDR
>ECC controller.
>>>>>>>>> +ECC support for DDR is available in half-bus width(16 bit)
>configuration only.
>>>>>>>>> +
>>>>>>>>> +Required properties:
>>>>>>>>> +- compatible: Should be "xlnx,ps7-ddrc" or "xlnx,ps7-ddrc-1.00.a"
>>>>>>>>
>>>>>>>> Is this an or or a xor?
>>>>>>>
>>>>>>> Compatible string should be just xlnx,zynq-ddrc-1.00.a.
>>>>>>> Nothing with ps7.
>>>>>>
>>>>>> Isn't this vendor IP? IMHO, this should be something completely
>>>>>> different. Or if you want some Zynq-specific compat string it should
>>>>>> refer to an actual version string associated with Zynq. 1.00.a is not,
>>>>>> AFAIK.
>>>>>
>>>>> I have checked with Punnaiah that this is Synopsys DDR memory
>controller.
>>>>> Zynq is based on 1.4 version with some customization.
>>>>> It means I think reasonable solution is
>>>>> call it drivers/edac/synopsys_edac.c
>>>>> rename zynq_ in driver to synopsys_ and
>>>>> use xlnx,zynq-ddrc-1.00.a compatible string because zynq is not using
>>>>> clean synopsys version.
>>>>>
>>>>> I am not getting point why you don't like 1.00.a suffix here.
>>>>> Because of historical point of view compatible strings should be
>different
>>>>> for early silicon, silicon v1, silicon v2, silicon v3, etc
>>>>> but we haven't used it at all that's why we can use xilinx scheme
>>>>> which we are using for our soft IPs.
>>>>
>>>> Well, but you refer to Zynq which has silicon revisions you can use to
>>>> refer to a specific Zynq version. That matches data sheets. Zynq-1.00.a
>>>> is just completely made up and wouldn't be found in any data sheet.
>>>
>>> I didn't reply this one but we discussed this with Soren over phone.
>>> No problem to use Synopsys version A07 according TRM.
>>>
>>> Then compatible string is
>>> xlnx,zynq-ddrc-A07 and file name is synopsys_edac.c
>>
>> This seems to make sense. I'm never sure whether leading zeros are
>> actually needed and tend to remove them, but in general this looks like
>> a reasonable string to identify Zynq's DDR controller.
>
>A07 I found in Zynq TRM and probably has any conection to synopsys version
>scheme.
I have discussed with the design team and confirmed that the synopsis IP
version is 1.4 and looks like it is wrongly updated in TRM as A07.
So, I am going to use compatible string as xlnx,zynq-ddrc-1.4 and file name
as synopsys_edac.c and send you the updated patch soon.
Thanks for the review and suggestions

Regards,
Punnaiah
>
>Thanks,
>Michal
>
>
>



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
