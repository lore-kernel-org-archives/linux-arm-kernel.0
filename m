From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 20 Nov 2013 11:22:10 +0100
Subject: [alsa-devel] Bug? Sound support for at91sam9x5-wm8731 based boards
In-Reply-To: <033601cee552$7c2c2570$74847050$@com>
References: <1384878685-1515-1-git-send-email-tony@atomide.com>
 <1384878685-1515-3-git-send-email-tony@atomide.com>
 <031f01cee547$950b5670$bf220350$@com>
 <CACQ1gAgykmgPKY4SHujnNtm4Sr=wt5knLkQL-MRS_pC73bOi4Q@mail.gmail.com>
 <033601cee552$7c2c2570$74847050$@com>
Message-ID: <CACQ1gAhvS7PSbK0SuhrB8TPS8Rkd-AdqZ-=T+Ntjyx7PsR7XaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[added Nicolas Ferre and Bo Shen ]

2013/11/19 Zhong Li <zql@glomationinc.com>:
>> Can you give a little more background ? :
>> - What kernel ?
>> - Command line to reproduce ?
>>
>> Richard.
>
> One of the testing hardware is the Atmel at91sam9g25-ek (the CPU module and the carrier board).  We tried both the 2.6.39 patched with the Atmel patches and the mainline 3.12-rc.  The command to test the sound is just the simple aplay <sound-test-file>.  The wav file is available here, https://drive.google.com/file/d/0B3TSFX4Mq9PoeTdJOGVaZk5rTWM/edit?usp=sharing.
>
> Thanks

Ok, I reproduce the bug on g35-ek with a v3.11.7+(sam9x5 sound patches) kernel

So, *sometimes*,  the left and right channel are swapped. ( I found
also the ratio 1 out of 6 (but once it has happened, it seems to be
more often))
I tested that with the file given by Zhong Li, and with a file I
created with audacity (440Hz only on right channel).
I could see at the scope that the channels are swapped before the
w8731 codec (the data on the TD line are sometime on the low edge of
TF, instead of always being on the high edge (I2S mode)).
There's, in both cases, a clock period (TK) between the rising/falling
edge of TF and the 1st data bit on TD, so the mode is always I2S, and
the channel data are swapped.

I'll try to have a look (but I don't have much time right now)

If someone could test that on a sam9g20 or a WM8904 based board, since
they share the same DAI format, they may have the same problem.

Thanks !
Richard

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
