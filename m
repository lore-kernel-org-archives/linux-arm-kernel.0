From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 21 Jan 2015 17:53:40 -0800
Subject: [PATCH 8/8] msm: scm: Move the scm driver to drivers/soc/qcom
In-Reply-To: <CAOesGMh1HE+hMP0VWr2vaHCp2itVjpQeiiFL6r9WeJUFes5tvw@mail.gmail.com>
References: <1407202310-3359-1-git-send-email-sboyd@codeaurora.org>
 <1407202310-3359-9-git-send-email-sboyd@codeaurora.org>
 <CAOesGMh1HE+hMP0VWr2vaHCp2itVjpQeiiFL6r9WeJUFes5tvw@mail.gmail.com>
Message-ID: <CAJAp7OgtnTN3H+zSazK2Xeob6wxpf9Ws=tibAupzP1cF31G=Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 5:13 PM, Olof Johansson <olof@lixom.net> wrote:
[..]
> On Mon, Aug 4, 2014 at 6:31 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> Architectural changes in the ARM Linux kernel tree mandate
>> the eventual removal of the mach-* directories. Move the
>> scm driver to drivers/soc/qcom and the scm header to
>> include/soc/qcom to support that removal.
>
> The idea is not blindly move one dumping ground to a new place.
>
> I see only two exported functions from scm.c:
>
> scm_get_version: This is not used anywhere in the kernel and can just be removed
> scm_call: This is used by scm-boot, and would be better to translate
> over to firmware_ops in the first place.
>

Hi Olof,

I started this a while ago, as it felt like the right thing to do <tm>.

The problem with this approach is that e.g. firmware loading is
partially handled through this interface. So implementing a remoteproc
driver for wifi etc required me to add 6 new ops to the struct,
loading the modem looks like it requires one more. HDMI requires one.

Looking at the downstream branch there's a bunch more (20+), so we
would explode the firmware_ops struct with Qualcomm "specific" ops.
This is not necessarily a bad idea, but needs to be considered before
we jump the gun.


I haven't looked at the arm64 stuff in detail, but it looks to be
shared between the two platforms, so either way it seems like the
right approach to have this moved out to drivers/soc/qcom.

Regards,
Bjorn
