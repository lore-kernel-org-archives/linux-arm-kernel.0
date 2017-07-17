From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 17 Jul 2017 14:57:19 +0800
Subject: [PATCH 4/4] drm/sun4i: make sure we don't have a commit pending
In-Reply-To: <20170717065504.xnahsboer3fh4k3i@flea>
References: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
 <a6dfec7ea3598c64f6653e9b8b5febac79172341.1499956639.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64KnB_zU0yk7MsGr9WRK1wpWq1xOj_cNuQ4mSQJeAGarw@mail.gmail.com>
 <20170717065504.xnahsboer3fh4k3i@flea>
Message-ID: <CAGb2v676F2ye7fDUSFwzWMxd8rF7_5YAxn+u+MNG-U2PuaDDoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 2:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Jul 14, 2017 at 04:56:01PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Thu, Jul 13, 2017 at 10:41 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > In the earlier display engine designs, any register access while a commit
>> > is pending is forbidden.
>> >
>> > One of the symptoms is that reading a register will return another, random,
>> > register value which can lead to register corruptions if we ever do a
>> > read/modify/write cycle.
>>
>> Alternatively, if changes to the backend (layers) are guaranteed to happen
>> while the CRTC is disabled (which seems to be the case after looking at
>> drm_atomic_helper_commit_planes and drm_atomic_helper_commit_tail), we
>> could just turn on register auto-commit all the time and not deal with
>> this.
>
> As far as I understand, it will only be the case if we need a new
> modeset or we changed the active CRTC or connectors. But if you change
> only the format, buffers or properties it won't be the case, and we'll
> need to commit.

So in other words, if someone were to use it for actual compositing and
moved the upper composited layer around, we would need commit support to be
safe.

Sounds more or less like something a video player would do.

Thanks
ChenYu
