From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Dec 2013 09:54:21 -0700
Subject: [PATCH 1/3] mfd: always assign of_node in mfd_add_device()
In-Reply-To: <20131210084042.GN12675@lee--X1>
References: <1386626809-6251-1-git-send-email-swarren@wwwdotorg.org>
 <20131210084042.GN12675@lee--X1>
Message-ID: <52A7473D.5020109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 01:40 AM, Lee Jones wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> mfd_add_device() assigns .of_node in the device objects it creates only
>> if the mfd_cell for the device has the .of_compatible field set and the
>> DT node for the top-level MFD device contains a child whose compatible
>> property matches the cell's .of_compatible field.
>>
>> This leaves .of_node unset in many cases. When this happens, entries in
>> the DT /aliases property which refer to the top-level MFD DT node will
>> never match the MFD child devices, hence causing the requested alias not
>> to be honored.
>>
>> Solve this by setting each MFD child device's .of_node equal to the top-
>> level MFD device's .of_node field in the cases where it would otherwise
>> remain unset.
> 
> How sure are you that this will be void of repercussions?

I'm simply hopeful:-) It doesn't seem likely that this would cause any
issues, since presumably any devices that are being instantiated from DT
either already work correctly, or wouldn't be affected by this change
since they're manually searching whatever the appropriate DT node is.
Are there any particular points you think I should look into?

>> The first use-case for this will be aliases for the TPS6586x's RTC
>> device.
> 
> Isn't it viable to supply the of_compatible strings for these nodes
> and search the parent for its alias property instead?

I did think of that, but there are two reasons I chose not to do that
initially:

a) It requires that every single top-level MFD driver be edited to set
the .of_compatible field in their mfd_cells array, whereas this patch
automatically works for all drivers.

b) The mfd_cells .of_compatible field is a single entry, whereas a
top-level MFD driver could support an arbitrary number of DT compatible
values. I suppose one could work around this by setting the mfd_cells
.of_compatible field at run-time based on the actual compatible value of
the top-level DT node, but that feels icky.
