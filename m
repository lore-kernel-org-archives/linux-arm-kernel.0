From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Thu, 19 Jul 2018 14:36:21 -0400
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
Message-ID: <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/19/2018 10:46 AM, James Morse wrote:
> On 19/07/18 15:01, Borislav Petkov wrote:
>> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
>>> Enable per-layer error reporting for ARM systems so that the error
>>> counters are incremented per-DIMM.
>>>
>>> On ARM systems that use firmware first error handling it is understood
> understood by whom? Is this written down somewhere, or is it the convention. (in
> which case, lets get it written down somewhere)
Hey Boris, James,

It has just been convention, but Harb recently brought up the idea of adding it 
to SBBR.
>>> that card=channel and module=DIMM on that channel. Populate that
> I'm guessing this is the mapping between CPER records and the DMItable data.
Unfortunately the DMI table doesn't actually have channel and DIMM number values 
which
makes this more complicated than I originally thought...
>>> information and enable per layer error reporting for ARM systems so that
>>> the EDAC error counters are incremented based on DIMM number as per the
>>> SMBIOS table rather than just incrementing the noinfo counters on the
>>> memory controller.
> Does this work on x86, and its just the dmi/cper fields have a subtle difference?
There are CPU specific EDAC drivers for a lot of x86 folks and those drivers 
populate the layer information
in a custom way.

With more investigation and testing it turns out a simple patch like this is not 
going to work. This worked for
me on a 1DPC board since the card number turned out to always be the same as the 
index into the DMI table
to find the proper DIMM. On a 2DPC board this fails completely. The ghes_edac 
driver only sets up a single
layer so it is only using the card number with this patch. That setup can be 
seen here:

https://elixir.bootlin.com/linux/v4.18-rc5/source/drivers/edac/ghes_edac.c#L469

So it is only setting up a single layer with all the DIMMs on that layer. In 
order to properly enable the layers
to represent channel and DIMM number on that channel, we would need to have a 
way of determining the
number of channels (which would be layers[0].size) and the number of DIMMs each 
channel supported
(layers[1].size). There doesn't appear to be a way to determine that information 
at this point.

With the current ghes_edac setup, it seems the only way this could work would be 
to have the firmware
always report the module value to be the index into the DMI table that this DIMM 
information lives. When I
say index into the DMI table, I'm meaning the index into the list of "type 17" 
DMI entries. So, DIMM number
doesn't actually matter, what really matters is the ordering of the type 17 
entries in the DMI table.

This seems pretty hacky to me, so if anyone has other suggestions please share 
them. The goal is to be able to
enable the per layer error reporting in the ghes_edac driver so that the per 
dimm counters exposed in the
EDAC sysfs nodes are properly updated. The other obvious but more messy way 
would be to have notifiers
register to be called by ghes_edac and have a custom EDAC driver for each CPU to 
properly populate their layer
information.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
