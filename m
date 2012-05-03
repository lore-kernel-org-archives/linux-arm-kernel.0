From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Thu, 3 May 2012 22:55:44 +0200
Subject: [PATCH 1/2] cs89x0_platform : Use ioread16/iowrite16 instead of
 inw/outw
In-Reply-To: <201204301419.27119.arnd@arndb.de>
References: <1335779839-30420-1-git-send-email-jaccon.bastiaansen@gmail.com>
 <201204301419.27119.arnd@arndb.de>
Message-ID: <CAGzjT4cUPuwHQ-46saDWdFjweekWrYt7TTJMsUORGXd8FdLpLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

2012/4/30 Arnd Bergmann <arnd@arndb.de>:
> On Monday 30 April 2012, Jaccon Bastiaansen wrote:
>> The use of the inw/outw functions by the cs89x0 platform driver
>> results in NULL pointer references.
>>
>> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
>> ---
>> ?drivers/net/ethernet/cirrus/cs89x0.c | ? 12 ++++++++++++
>> ?1 files changed, 12 insertions(+), 0 deletions(-)
>
> It's actually broken on most platforms already, and the #ifdef is
> about to go away since IXP2xxx is getting removed in v3.5.
>
>> diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
>> index b9406cb..95737e9 100644
>> --- a/drivers/net/ethernet/cirrus/cs89x0.c
>> +++ b/drivers/net/ethernet/cirrus/cs89x0.c
>> @@ -369,6 +369,18 @@ writeword(unsigned long base_addr, int portno, u16 value)
>> ?{
>> ? ? ? ? __raw_writel(value, base_addr + (portno << 1));
>> ?}
>> +#elif defined(CONFIG_CS89x0_PLATFORM)
>> +static u16
>> +readword(unsigned long base_addr, int portno)
>> +{
>> + ? ? ? return ioread16(base_addr + portno);
>> +}
>> +
>> +static void
>> +writeword(unsigned long base_addr, int portno, u16 value)
>> +{
>> + ? ? ? iowrite16(value, base_addr + portno);
>> +}
>> ?#else
>> ?static u16
>> ?readword(unsigned long base_addr, int portno)
>
> I think the best solution would be to always using ioread32/iowrite32
> in the #else path, and change the ISA code to do an ioport_map
> for the base address, passing around the virtual address as an __iomem
> pointer.
>
> ? ? ? ?Arnd
> --

So if I understand you correctly you would like to have an
iopart_map() call in the cs89x0_probe() function and use the return
value of that iopart_map() call as ioaddr parameter of the
cs89x0_probe1() function. Is this correct? This would make the
cs89x0_probe() function similar to the cs89x0_platform_probe()
function where the return value of the ioremap() call is used as
ioaddr parameter of the cs89x0_probe1() function.

But why do you want to convert the current 16 bit accesses in the
#else path to 32 bit accesses? Why not using ioread16()/iowrite16()?


Regards,
  Jaccon
