From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 10:25:25 -0700
Subject: [PATCH 1/3] mfd: always assign of_node in mfd_add_device()
In-Reply-To: <20131211092435.GC16780@lee--X1>
References: <1386626809-6251-1-git-send-email-swarren@wwwdotorg.org>
 <20131211092435.GC16780@lee--X1>
Message-ID: <52B32C05.5010204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 02:24 AM, Lee Jones wrote:
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
>>
>> The first use-case for this will be aliases for the TPS6586x's RTC
>> device.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  drivers/mfd/mfd-core.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> I've tentatively applied this patch, but if it starts to cause more
> problems than it solves we'll have to endeavour to find a different
> solution.

OK, we've found a problem already! I guess we should drop or revert this
patch (do you need me to send a patch to do this?) and I'll send a
revised patch to the RTC core to look up aliases in a different way.

For the problem, see:
http://www.spinics.net/lists/arm-kernel/msg295627.html
