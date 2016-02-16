From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 16 Feb 2016 17:18:52 +0100
Subject: [PATCH net-next 08/10] bus: mvenus-mbus: Fix size test for
 mvebu_mbus_get_dram_win_info
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CCC5C65@AcuExch.aculab.com>
 (David Laight's message of "Thu, 14 Jan 2016 14:00:21 +0000")
References: <1452625834-22166-1-git-send-email-gregory.clement@free-electrons.com>
 <1452625834-22166-9-git-send-email-gregory.clement@free-electrons.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CCC5C65@AcuExch.aculab.com>
Message-ID: <87mvr0tyqb.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,
 
 On jeu., janv. 14 2016, David Laight <David.Laight@ACULAB.COM> wrote:

> From: Gregory CLEMENT
>> Sent: 12 January 2016 19:11
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/bus/mvebu-mbus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
>> index 3d1c0c3880ec..214bb964165b 100644
>> --- a/drivers/bus/mvebu-mbus.c
>> +++ b/drivers/bus/mvebu-mbus.c
>> @@ -964,7 +964,7 @@ int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr)
>>  	for (i = 0; i < dram->num_cs; i++) {
>>  		const struct mbus_dram_window *cs = dram->cs + i;
>> 
>> -		if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size)) {
>> +		if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size - 1)) {
>
> Wouldn't it be better to change the line to:
>> +		if (cs->base <= phyaddr && phyaddr < (cs->base +
>cs->size)) {

It doesn't work if there is 4GB of memory in this case we can have
cs->base + cs->size which wrap to 0 and the test fails. It was exactly
what happened on Armada XP GP board.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
