From: amit.virdi@st.com (Amit Virdi)
Date: Mon, 21 Oct 2013 16:59:54 +0530
Subject: copy from user broken on no-MMU (Was: Need advice: unable to
 mount filesystem)
In-Reply-To: <20131016082019.GA10079@pengutronix.de>
References: <511B8729.8040908@st.com>
 <CACRpkdb=zgaWkzoMtaWbMZXe_wUyszwsjmRC=03iMPDpU90N4w@mail.gmail.com>
 <511C751D.9090404@st.com>
 <CACRpkdaNL=y7Stgd2d=FLY9Zf4iSHjT8GMK+Ch8noe=De3cWfQ@mail.gmail.com>
 <511E222E.7050002@st.com> <525E233D.9060303@st.com>
 <20131016082019.GA10079@pengutronix.de>
Message-ID: <52651032.3040505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Uwe,

On 10/16/2013 1:50 PM, Uwe Kleine-K?nig wrote:
> Hello Amit,
>
> (fixed subject and added Nico to Cc:)
>
> On Wed, Oct 16, 2013 at 10:55:17AM +0530, Amit Virdi wrote:
>> I'm using cortex-R4 in my SoC. I figured earlier that the support
>> for MMU-less kernel was broken from Kernel v3.6 onwards. As a
>> result, I was facing problem in mounting the filesystem. Using git
>> bisect, I figured out that as a result of:
>>
>>> ARM: 7449/1: use generic strnlen_user and strncpy_from_user functions
>>
>> the file system was unable to mount on MMU-less kernel. Till date, I
>> have been using the following local fix [1]:
>>
>> ---
>> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
>> index 479a635..e5d549f 100644
>> --- a/arch/arm/include/asm/uaccess.h
>> +++ b/arch/arm/include/asm/uaccess.h
>> @@ -190,7 +190,7 @@ static inline void set_fs(mm_segment_t fs)
>>   #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)
>>
>>   #define user_addr_max() \
>> -	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
>> +	(segment_eq(get_fs(), KERNEL_DL) ? ~0UL : TASK_SIZE)
>>
>>   /*
>>    * The "__xxx" versions of the user access functions do not verify the
> I did:
>
> http://git.pengutronix.de/?p=ukl/linux.git;a=commitdiff;h=089c629270ccd7499a083b530ec6aecc101d078b
>
> but I'm not sure either this is correct. I asked here on the list back
> then with the same patch as your's[1].
>
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/170980/focus=191855

Yes, I see. So what do you think is the best way to resolve this 
problem? It is already lingering around for so long.

>> [2] The patch "ARM: move signal handlers into a vdso-like page"
>> introduced in v3.11-rc4 generates Prefetch abort while booting
>> kernel in MMU-less systems
> My M3 happily runs on v3.12-rc4.
>

I fixed a local problem and now I'm able to execute the Kernel on v3.12-rc5.

Regards
Amit Virdi
