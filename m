From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 17 Jan 2012 22:08:57 -0600
Subject: [RFC PATCH v2] ARM: imx: Add basic imx6q thermal management
In-Reply-To: <20120117092324.GV5446@pengutronix.de>
References: <1326775136-32115-1-git-send-email-rob.lee@linaro.org>
 <CAMXH7KEhv9LgvvJ-FnLfaFZNgvJu2gOhFDwpYHDzN9iCDXHjJw@mail.gmail.com>
 <CAMXH7KFdBQmh9eQYXU4Hzg=M9cxyJWzDKouYsGUp+POw0FRXqQ@mail.gmail.com>
 <20120117092324.GV5446@pengutronix.de>
Message-ID: <CAMXH7KFpCdLMdgBg9ES-rP+Wf=UaHmM5r09aL3RVv3akre0u7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha, one comment below.  Agree with the rest of your comments and a
v3 patch with these fixes will be coming shortly.

>> +static int th_sys_get_temp(struct thermal_zone_device *thermal,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned long *temp)
>> +{
>> + ? ? int tmp = 0;
>> +
>> + ? ? imx6q_get_temp(&tmp);
>> +
>> + ? ? /*
>> + ? ? ?* The thermal framework code stores temperature in unsigned long. Also,
>> + ? ? ?* it has references to "millicelcius" which limits the lowest
>> + ? ? ?* temperature possible (compared to Kelvin).
>> + ? ? ?*/
>> + ? ? if (likely(tmp > 0))
>
> Please no 'likely' in such slow pathes.
>

Why limit 'likely' and 'unlikely' to fast paths?  There usage should
also increase efficiency and thus power usage when used in
periodically/repetitively called code such as this.  In this case, the
increased efficiency will be extremely small but what is the downside
to using it here?
