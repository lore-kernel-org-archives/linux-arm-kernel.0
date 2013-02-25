From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 25 Feb 2013 07:58:33 -0300
Subject: [PATCH] cpufreq: highbank: do not initialize array with a loop
In-Reply-To: <CAOh2x=nDZpBaqjzO22k66Bb30mVEhAdy02EFDP9RDibA50Sx7A@mail.gmail.com>
References: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
 <CAOh2x=nDZpBaqjzO22k66Bb30mVEhAdy02EFDP9RDibA50Sx7A@mail.gmail.com>
Message-ID: <BLU0-SMTP837DD4DF438223EBC6536A8AF30@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

El 25/02/13 00:41, Viresh Kumar escribi?:
> On Sun, Feb 24, 2013 at 10:31 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
>> As uninitialized array members will be initialized to zero, we can
>> avoid using a for loop by setting a value to it.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> ---
>> Note that I don't own any device using this driver, it has only been compile
>> tested, but it shouldn't cause any issues.
>>
>>  drivers/cpufreq/highbank-cpufreq.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
>> index 66e3a71..30d4ae1 100644
>> --- a/drivers/cpufreq/highbank-cpufreq.c
>> +++ b/drivers/cpufreq/highbank-cpufreq.c
>> @@ -28,13 +28,9 @@
>>
>>  static int hb_voltage_change(unsigned int freq)
>>  {
>> -       int i;
>> -       u32 msg[HB_CPUFREQ_IPC_LEN];
>> +       u32 msg[HB_CPUFREQ_IPC_LEN] = {HB_CPUFREQ_CHANGE_NOTE};
>>
>> -       msg[0] = HB_CPUFREQ_CHANGE_NOTE;
>>         msg[1] = freq / 1000000;
> 
> I think this can also be part of the definition of array, isn't it?
> 
> So it would be something like:
> 
> u32 msg[HB_CPUFREQ_IPC_LEN] = {HB_CPUFREQ_CHANGE_NOTE, freq / 1000000};
> 

I incorrectly assumed that sparse would complain, but after testing I
see it doesn't. Thanks for pointing it out, I'll send a v2 in a minute.

Emilio
