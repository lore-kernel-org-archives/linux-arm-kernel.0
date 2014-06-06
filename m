From: dianders@google.com (Doug Anderson)
Date: Fri, 6 Jun 2014 11:02:47 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
Message-ID: <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash,

On Fri, Jun 6, 2014 at 10:36 AM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Doug,
>
> The first change in the kernel (clearing an iRAM location) is needed
> because of an unnecessary change that we are carrying in the Chrome
> U-boot. There is no reason for us to have the workaround in the
> mainline kernel. Rather, we should remove the check from our u-boot.
> However AFAIR a clean-up patch that I had posted internally was not
> accepted as we had frozen the SPL at the time.

Ah, is that this one, or a different one?

https://chromium-review.googlesource.com/#/c/66049/


If we land that patch now it won't help since nobody is going to be
updating their read-only firmware.  We'll need to put code somewhere
that fixes it.


> The second change is to enable snoops for boot cluster. Internally, we
> were disabling the snoops for both the clusters at power off and
> enabling it in power_up_setup and power_up. However, I dropped the
> approach due to problems pointed out by Nicolas here
> http://www.spinics.net/lists/arm-kernel/msg324091.html related to
> cpuidle. Hence, we turn it on at the u-boot.

I think I followed all that.  What you're saying is that our kernel
dynamically enables and disables snoops as needed, but Nicolas pointed
out that it was unsafe (though apparently we're not seeing problems in
our usage).

...so now the kernel doesn't touch the snoops and assumes that U-Boot
turned them on.


Ugh.

-Doug
