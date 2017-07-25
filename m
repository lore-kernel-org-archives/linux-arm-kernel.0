From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 25 Jul 2017 10:35:52 +0100
Subject: [PATCH v5 18/19] coresight tmc: Add support for Coresight SoC 600
 TMC
In-Reply-To: <CANLsYkzMSTXaCk5d_J8Ea4wpoqbfnDx0jCrwodxkSc7hrzLEgQ@mail.gmail.com>
References: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
 <1500545849-23724-19-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkzMSTXaCk5d_J8Ea4wpoqbfnDx0jCrwodxkSc7hrzLEgQ@mail.gmail.com>
Message-ID: <027be70e-d5ff-c0ac-7c85-fcabd5c56628@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/17 18:12, Mathieu Poirier wrote:
> On 20 July 2017 at 04:17, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> The coresight SoC 600 supports ETR save-restore which allows us
>> to restore a trace session by retaining the RRP/RWP/STS.Full values
>> when the TMC leaves the Disabled state. However, the TMC doesn't
>> have a scatter-gather unit in built.
>>
>> Also, TMCs have different PIDs in different configurations (ETF,
>> ETB & ETR), unlike the previous generation.
>>
>> While the DEVID exposes some of the features/changes in the TMC,
>> it doesn't explicitly advertises the new save-restore feature
>> as described above.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-tmc.c | 16 ++++++++++++++++
>>  drivers/hwtracing/coresight/coresight-tmc.h |  4 ++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
>> index c4a5dea..e754a3e 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
>> @@ -442,6 +442,22 @@ static struct amba_id tmc_ids[] = {
>>                 .id     = 0x000bb961,
>>                 .mask   = 0x000fffff,
>>         },
>> +       {
>> +               /* Coresight SoC 600 TMC-ETR/ETS */
>> +               .id     = 0x000bb9e8,
>> +               .mask   = 0x000fffff,
>> +               .data   = (void *)(unsigned long)CORESIGHT_SOC_600_ETR_CAPS,
>
> It the casting to unsigned long mandatory?

Yes. Given the ETR caps is u32, we don't want a trouble with
little/big endian switch. Also, it keeps the compiler happy when you
upsize an integer to a pointer directly.

e.g:

$ cat cast.c
int main(void)
{
	void *ptr;
	int a;
	ptr = (void *)a;
	return 0;
}

Compiler warns:

cc     cast.c   -o cast
cast.c: In function ?main?:
cast.c:5:8: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   ptr = (void *)a;
         ^

Cheers
Suzuki
