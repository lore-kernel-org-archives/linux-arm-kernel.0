From: songjun.wu@atmel.com (Wu, Songjun)
Date: Thu, 10 Sep 2015 10:31:04 +0800
Subject: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
In-Reply-To: <20150909095245.GG9751@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk> <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk> <55EEAC01.3080409@atmel.com>
 <20150908122322.GB9751@sirena.org.uk> <55EFA478.1000109@atmel.com>
 <20150909095245.GG9751@sirena.org.uk>
Message-ID: <55F0EB68.9070800@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/9/2015 17:52, Mark Brown wrote:
> On Wed, Sep 09, 2015 at 11:16:08AM +0800, Wu, Songjun wrote:
>> On 9/8/2015 20:23, Mark Brown wrote:
>
>>> If you want to have three controls you need to write code so that the
>>> user can only change one of them from 0dB at once, returning an error
>>> otherwise.  That was why it looked like they were three separate
>>> controls.
>
>> If user operates two or tree controls at the same time, for my
>> understanding, these operations are serial actually in kernel, not parallel,
>> and the last operation will be effective. I only write the function
>> 'classd_get_eq_enum' to get the enumeration value, if user changes one of
>> controls, the other controls will get 0dB. Is my understanding correct?
>
> Yes, that's what's going to end up happening but it's not how controls
> are expected to behave - applications will expect changing one control
> to leave others unaffected so it's better to return an error rather than
> change the other control.
>
If application change non EQ controls, the others will be unaffected. 
But the classD IP can only supports one EQ control at once, these three 
EQ controls point to the same register field, if application set a 
different EQ control, the error occurs, there will be many errors, it's 
not very reasonable to application. The best way I think is if 
application set one EQ control, the other EQ controls will change to 
0dB, it's also consistent with fact.
