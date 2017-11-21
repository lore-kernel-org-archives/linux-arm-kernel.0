From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 21 Nov 2017 13:28:13 -0800
Subject: [PATCH v4 10/12] arm64: vdso: replace gettimeofday.S with global
 vgettimeofday.C
In-Reply-To: <20171121180319.tawkc42jjx4ow3hg@tarantula.localdomain>
References: <20171031183306.81375-1-salyzyn@android.com>
 <7775cc5e-4a24-1e33-aae5-6181ca018d80@android.com>
 <61EF90BA-9A6D-4DC4-A1F4-BEAA210D708C@redhat.com>
 <20171121180319.tawkc42jjx4ow3hg@tarantula.localdomain>
Message-ID: <a560894c-fd0d-9f29-3847-9700bf5a1008@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2017 10:03 AM, Jeffrey Bastian wrote:
> On Thu, Nov 02, 2017 at 12:22:36AM -0400, Jon Masters wrote:
>> On Nov 2, 2017, at 06:14, Mark Salyzyn <salyzyn@android.com> wrote:
>>> Holding off respin or followup patch until after we get a response
>>> from Jon Masters <jcm@readhat.com> on their QE tests on this patch
>>> series.
>> Copying Jeff Bastian who owns QE. Jeff, can you recall what test was
>> failing when we tried the gettimeofday C rewrite VDSO patches?
> The LTP clock_getres01 test was failing when we tried the initial
> implementation of gettimeofday-in-C.  This would be a good place to
> start when testing the new version of the patches.
>
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/clock_getres/clock_getres01.c
>
>
Thanks.

I ran the test (32 and 64 bit) on my latest work (but back-ported to 
4.9) and it passes. I did not change __vdso_clock_getres or the fallback 
(syscall) handler in the patch series though, so the failure has me 
wondering. Could you re-run the test with latest to be sure, and I will 
look into setting up to test with a ToT kernel (after the thanksgiving 
break).

Using bionic libc, with advance modifications to utilize 
__vdso_clock_getres; required in order to support the test.

NB: in AOSP _today_ bionic does _not_ propagate the errno correctly on 
the __vdso_clock_gettime vdso path and will understandably fail the 
similar tests. The public rubber stamp of __vdso_clock_gettime code to 
support __vdso_clock_getres will not work. errno propagation issue will 
be fixed in bionic.

-- Mark
