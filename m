From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Jan 2018 23:45:18 +0100
Subject: [PATCH] s3mci: mark debug_regs[] as static
In-Reply-To: <CAPDyKFoxizZ5vJ4h_hSo=WaqzjMc7Zq59njuESTdeMaXCV1YQA@mail.gmail.com>
References: <20180103092705.1949763-1-arnd@arndb.de>
 <CAPDyKFoxizZ5vJ4h_hSo=WaqzjMc7Zq59njuESTdeMaXCV1YQA@mail.gmail.com>
Message-ID: <CAK8P3a3U=J7knkExNfTG9aBy7UAw9fmwijOvq0PDRwzz73iH+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 3, 2018 at 5:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 January 2018 at 10:26, Arnd Bergmann <arnd@arndb.de> wrote:
>> The global array clashes with a newly added symbol of the same name:
>>
>> drivers/staging/ccree/cc_debugfs.o:(.data+0x0): multiple definition of `debug_regs'
>> drivers/mmc/host/s3cmci.o:(.data+0x70): first defined here
>>
>> We should fix both, this one addresses the s3cmci driver by removing
>> the symbol from the global namespace.
>>
>> Fixes: 9bdd203b4dc8 ("s3cmci: add debugfs support for examining driver and hardware state")
>
> Seems like we need a stable tag as well, would you mind adding it in
> the next re-spin?

It doesn't seem necessary here, this only causes problems on the latest
linux-next kernel that has the b3ec9a6736f2 commit as well.

Obviously, you can just add the Cc:stable tag when applying the patch
when you consider it appropriate.

>> Fixes: b3ec9a6736f2 ("staging: ccree: staging: ccree: replace sysfs by debugfs interface")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/mmc/host/s3cmci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
>> index 36daee1e6588..24b27e0957e7 100644
>> --- a/drivers/mmc/host/s3cmci.c
>> +++ b/drivers/mmc/host/s3cmci.c
>> @@ -1421,7 +1421,7 @@ static const struct file_operations s3cmci_fops_state = {
>>
>>  #define DBG_REG(_r) { .addr = S3C2410_SDI##_r, .name = #_r }
>>
>> -struct s3cmci_reg {
>> +static struct s3cmci_reg {
>>         unsigned short  addr;
>>         unsigned char   *name;
>>  } debug_regs[] = {
>
> I am not very fond of these kind of declarations/definitions. How
> about if we instead move the declaration of debug_regs[] to a separate
> line? Moreover, should it be const?
>
> static struct s3cmci_reg debug_regs[] = {

Ok, I'll resend with that changed.

      Arnd
