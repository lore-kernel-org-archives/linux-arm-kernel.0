From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Oct 2015 09:57:45 +0200
Subject: [PATCH v5 1/4] ARM: mvebu: add broken-idle option
In-Reply-To: <CAOesGMjUG0Ws7X7sw3H=8BNTNrwqmfPREpP0MK8RoJssAgiJ-g@mail.gmail.com>
 (Olof Johansson's message of "Thu, 22 Oct 2015 10:40:57 -0700")
References: <1444140824-24132-1-git-send-email-simon.guinot@sequanux.org>
 <1444140824-24132-2-git-send-email-simon.guinot@sequanux.org>
 <CAOesGMjUG0Ws7X7sw3H=8BNTNrwqmfPREpP0MK8RoJssAgiJ-g@mail.gmail.com>
Message-ID: <87oafq2f0m.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon and Vincent,
 
 On jeu., oct. 22 2015, Olof Johansson <olof@lixom.net> wrote:

>> +static int broken_idle(struct device_node *np)
>> +{
>> +       if (of_property_read_bool(np, "broken-idle")) {
>> +               pr_warn("CPU idle is currently broken: disabling\n");
>> +               return 0;
>> +       }
>> +
>> +       return 1;
>> +}
>
> This is confusing. The function is called broken_idle(), but it
> returns 0 if idle is broken and 1 if it isn't.
>
> It means these tests look odd:
>
>> +
>>  static __init int armada_370_cpuidle_init(void)
>>  {
>>         struct device_node *np;
>> @@ -387,7 +397,9 @@ static __init int armada_370_cpuidle_init(void)
>>         np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
>>         if (!np)
>>                 return -ENODEV;
>> -       of_node_put(np);
>> +
>> +       if (!broken_idle(np))
>> +               goto end;
>
> So, the way I read this when I read just this code is: "If idle is NOT
> broken, then don't bother set up any of the idle stuff".
>
> Please turn this the other way around so others don't make the same
> mistake when reading the code.
>
> I know it might come across as bikesheddy and nitpicky, but
> readability trumps most other things when it comes to new code. :-/

Could you send an updated version ? Then I will be able to make a new
pull request following it as requested by Olof. Then it will still be
part of 4.4.

Thanks,

Gregory

>
>
>
> -Olof

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
