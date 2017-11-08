From: aleksey.makarov@cavium.com (Aleksey Makarov)
Date: Wed, 8 Nov 2017 15:14:30 +0300
Subject: [PATCH net-next 1/2] net: add support for Cavium PTP coprocessor
In-Reply-To: <1d765627-edb1-cc0f-65bc-cf061687a8c6@caviumnetworks.com>
References: <20171107190704.15458-1-aleksey.makarov@cavium.com>
 <20171107190704.15458-2-aleksey.makarov@cavium.com>
 <1d765627-edb1-cc0f-65bc-cf061687a8c6@caviumnetworks.com>
Message-ID: <13187c17-6a73-f916-f919-2386b55ce047@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/07/2017 10:49 PM, David Daney wrote:
> On 11/07/2017 11:07 AM, Aleksey Makarov wrote:
>> From: Radoslaw Biernacki <rad@semihalf.com>
>>
>> This patch adds support for the Precision Time Protocol
>> Clocks and Timestamping hardware found on Cavium ThunderX
>> processors.
>>
>> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
>> ---
>> ? drivers/net/ethernet/cavium/Kconfig???????????? |? 13 +
>> ? drivers/net/ethernet/cavium/Makefile??????????? |?? 1 +
>> ? drivers/net/ethernet/cavium/common/Makefile???? |?? 1 +
>> ? drivers/net/ethernet/cavium/common/cavium_ptp.c | 353 ++++++++++++++++++++++++
>> ? drivers/net/ethernet/cavium/common/cavium_ptp.h |? 78 ++++++
>> ? 5 files changed, 446 insertions(+)
>> ? create mode 100644 drivers/net/ethernet/cavium/common/Makefile
>> ? create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.c
>> ? create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.h
>>
> [...]
>> +
>> +/* The Cavium PTP can *only* be found in SoCs containing the ThunderX
>> + * ARM64 CPU implementation.? All accesses to the device registers on this
>> + * platform are implicitly strongly ordered with respect to memory
>> + * accesses.
> 
> I believe that is not correct.  I/O register accesses are implicitly
> ordered with respect to other I/O register accesses.  However, with
> respect to memory accesses, no ordering is imposed.  Therefore, one
> must be very careful not to introduce subtile memory ordering bugs
> with these things when using the unordered versions.

I will fix it in the next version.

Thank you
Aleksey Makarov

>> + * So writeq_relaxed() and readq_relaxed() are safe to use with
>> + * no memory barriers in this driver.? The readq()/writeq() functions add
>> + * explicit ordering operation which in this case are redundant, and only
>> + * add overhead.
> 
> 
> Also it should be noted that on production silicon, the performance difference between the "relaxed" variant and the normal variant of read*/write* is often negligible.
> 
> 
>> + */
>> +
>> +static u64 cavium_ptp_reg_read(struct cavium_ptp *clock, u64 offset)
>> +{
>> +??? return readq_relaxed(clock->reg_base + offset);
>> +}
>> +
>> +static void cavium_ptp_reg_write(struct cavium_ptp *clock, u64 offset, u64 val)
>> +{
>> +??? writeq_relaxed(val, clock->reg_base + offset);
>> +}
>> +
> 
> Are the PTP register access really so much in the hot path that using the relaxed variants can be measured here?? If not, would it make the driver look cleaner to remove these and just use readq/writeq calls directly? in the body of the driver?
> 
> David.
