From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Mar 2014 17:50:15 +0100
Subject: [RFC PATCH] edac: zynq: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <20140312161344.GA3000@xsjandreislx>
References: <4adb2b4b-2ad6-42b9-929e-cc062f817245@TX2EHSMHS021.ehs.local>
 <20140310105655.GH14999@e106331-lin.cambridge.arm.com>
 <531DA900.5060202@monstr.eu>
 <fa35006e-055d-4ef2-9b65-a0f8cc6a0c8f@AM1EHSMHS016.ehs.local>
 <531ECA33.8050803@monstr.eu> <20140311155057.GJ13293@xsjandreislx>
 <c7840b9d-4c03-4680-9a0e-fb256f3743b4@AM1EHSMHS010.ehs.local>
 <20140312161344.GA3000@xsjandreislx>
Message-ID: <345f2b89-660c-4eac-bee2-ea8debdc5fbc@CH1EHSMHS031.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2014 05:13 PM, S?ren Brinkmann wrote:
> On Wed, 2014-03-12 at 11:27AM +0100, Michal Simek wrote:
>> On 03/11/2014 04:50 PM, S?ren Brinkmann wrote:
>>> On Tue, 2014-03-11 at 09:32AM +0100, Michal Simek wrote:
>>>> On 03/10/2014 11:32 PM, S?ren Brinkmann wrote:
>>>>> On Mon, 2014-03-10 at 12:58PM +0100, Michal Simek wrote:
>>>>>> On 03/10/2014 11:56 AM, Mark Rutland wrote:
>>>>>>> On Sun, Mar 09, 2014 at 02:57:16AM +0000, Punnaiah Choudary Kalluri wrote:
>>>>>>>> Added EDAC support for reporting the ecc errors of zynq ddr controller.
>>>>>>>> The ddr ecc controller corrects single bit errors and detects double bit
>>>>>>>> errors
>>>>>>>>
>>>>>>>> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
>>>>>>>> ---
>>>>>>>>  .../devicetree/bindings/edac/zynq_edac.txt         |   18 +
>>>>>>>>  drivers/edac/Kconfig                               |    7 +
>>>>>>>>  drivers/edac/Makefile                              |    1 +
>>>>>>>>  drivers/edac/zynq_edac.c                           |  613 ++++++++++++++++++++
>>>>>>>>  4 files changed, 639 insertions(+), 0 deletions(-)
>>>>>>>>  create mode 100644 Documentation/devicetree/bindings/edac/zynq_edac.txt
>>>>>>>>  create mode 100644 drivers/edac/zynq_edac.c
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/edac/zynq_edac.txt b/Documentation/devicetree/bindings/edac/zynq_edac.txt
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..c21ff83
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/edac/zynq_edac.txt
>>>>>>>> @@ -0,0 +1,18 @@
>>>>>>>> +Zynq EDAC driver, it does reports the DDR ECC single bit errors that are
>>>>>>>> +corrected and double bit ecc errors that are detected by the DDR ECC controller.
>>>>>>>> +ECC support for DDR is available in half-bus width(16 bit) configuration only.
>>>>>>>> +
>>>>>>>> +Required properties:
>>>>>>>> +- compatible: Should be "xlnx,ps7-ddrc" or "xlnx,ps7-ddrc-1.00.a"
>>>>>>>
>>>>>>> Is this an or or a xor?
>>>>>>
>>>>>> Compatible string should be just xlnx,zynq-ddrc-1.00.a.
>>>>>> Nothing with ps7.
>>>>>
>>>>> Isn't this vendor IP? IMHO, this should be something completely
>>>>> different. Or if you want some Zynq-specific compat string it should
>>>>> refer to an actual version string associated with Zynq. 1.00.a is not,
>>>>> AFAIK.
>>>>
>>>> I have checked with Punnaiah that this is Synopsys DDR memory controller.
>>>> Zynq is based on 1.4 version with some customization.
>>>> It means I think reasonable solution is
>>>> call it drivers/edac/synopsys_edac.c
>>>> rename zynq_ in driver to synopsys_ and
>>>> use xlnx,zynq-ddrc-1.00.a compatible string because zynq is not using
>>>> clean synopsys version.
>>>>
>>>> I am not getting point why you don't like 1.00.a suffix here.
>>>> Because of historical point of view compatible strings should be different
>>>> for early silicon, silicon v1, silicon v2, silicon v3, etc
>>>> but we haven't used it at all that's why we can use xilinx scheme
>>>> which we are using for our soft IPs.
>>>
>>> Well, but you refer to Zynq which has silicon revisions you can use to
>>> refer to a specific Zynq version. That matches data sheets. Zynq-1.00.a
>>> is just completely made up and wouldn't be found in any data sheet.
>>
>> I didn't reply this one but we discussed this with Soren over phone.
>> No problem to use Synopsys version A07 according TRM.
>>
>> Then compatible string is
>> xlnx,zynq-ddrc-A07 and file name is synopsys_edac.c
> 
> This seems to make sense. I'm never sure whether leading zeros are
> actually needed and tend to remove them, but in general this looks like
> a reasonable string to identify Zynq's DDR controller.

A07 I found in Zynq TRM and probably has any conection to synopsys version scheme.

Thanks,
Michal
