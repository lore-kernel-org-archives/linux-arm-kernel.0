From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 12 Feb 2014 16:14:27 +0100
Subject: [PATCH v2] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <20140212131834.GP26684@n2100.arm.linux.org.uk>
References: <1392050756-11145-1-git-send-email-fabrice.gasnier@st.com>
 <52FB71A3.5010505@stericsson.com>
 <20140212131834.GP26684@n2100.arm.linux.org.uk>
Message-ID: <52FB8FD3.1020407@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 02/12/2014 02:18 PM, Russell King - ARM Linux wrote:
> On Wed, Feb 12, 2014 at 02:05:39PM +0100, Fabrice GASNIER wrote:
>> Hi,
>>
>> Any comments on this patch ?
>>
>> Russell, can I add this patch to your patch tracker system ?
> I don't see how this works on anything but ARMv7M.

Sorry, i'm confused.

In the first patch you proposed,
http://archive.arm.linux.org.uk/lurker/message/20140131.170827.d752a1cc.en.html
there was :

#ifndef CONFIG_CPU_V7M

[...]

/* Enable imprecise aborts */
[...]

#else /* ifndef CONFIG_CPU_V7M */

I understand that abort handling (vectors and masking ?) is different on 
armv7-m ?
Or should we make no distinction ?

I have kept the same principle regarding abort enable/disable macro.

#if __LINUX_ARM_ARCH__ >= 6
[...]

#ifndef CONFIG_CPU_V7M
#define local_abt_enable()  __asm__("cpsie a    @ __sta" : : : "memory", 
"cc")
#define local_abt_disable() __asm__("cpsid a    @ __cla" : : : "memory", 
"cc")
#else
#define local_abt_enable()    do { } while (0)
#define local_abt_disable()    do { } while (0)
#endif

#else
[...]
#define local_abt_enable()    do { } while (0)
#define local_abt_disable()    do { } while (0)
#endif

Sorry if this is silly question ...

BR,
Fabrice
>
