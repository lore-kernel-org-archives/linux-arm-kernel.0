From: daniel@fooishbar.org (Daniel Stone)
Date: Wed, 2 Dec 2015 14:22:16 +0000
Subject: [RFC PATCH 3/9] drm/rockchip: Convert to support atomic API
In-Reply-To: <CAPj87rO9_sXZHidTpNs_ubFaUX8ZtytK=bLpQSQwSy5G2-JGEA@mail.gmail.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
 <1448940391-23333-4-git-send-email-mark.yao@rock-chips.com>
 <CAPj87rPtWgH2WE7_EEC-Q41c7Ew2z8CwPMMQD+cC08G7qNZTeg@mail.gmail.com>
 <565D68F0.3010905@rock-chips.com>
 <CAPj87rO9_sXZHidTpNs_ubFaUX8ZtytK=bLpQSQwSy5G2-JGEA@mail.gmail.com>
Message-ID: <CAPj87rPT7v-SBDbGm9ftER+ykwNBxT5Vtdq_vTXzePQxzCwR4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2 December 2015 at 14:18, Daniel Stone <daniel@fooishbar.org> wrote:
> On 1 December 2015 at 09:31, Mark yao <mark.yao@rock-chips.com> wrote:
>>     Can you share your Weston environment to me, I'm interesting to test drm
>> rockchip on weston.
>
> Of course. You can download Weston from http://wayland.freedesktop.org
> - the most interesting dependencies are libevdev, libinput, and
> wayland itself. If you are building newer Weston from git, you'll need
> the wayland-protocols repository as well, from
> anongit.freedesktop.org/git/wayland/wayland-protocols/. Please let me
> know privately if you need some more help with building these, but
> they should be quite straightforward.

Sorry, left one thing out. When running, if you do not have
GBM/Wayland enabled for Mali (or no Mali support), you should run
with:
weston --use-pixman
or:
weston-launch -- --use-pixman

Launching from SSH is a bit more complicated:
sudo weston-launch --user=$username --tty=/dev/tty3 -- --use-pixman

(Replace tty3 with the TTY of your choice: it must be in text mode.)

Once you have done this, you will find three issues:
  - passing -1 to drm_send_vblank event causes OOPS - now fixed in your tree
  - not sending pageflip events for same-fb flips causes Weston hang -
fixed with my patch, and I believe now fixed in atomic (though it may
still have some timing issues; I hope to get to review this early next
week)
  - not having a preclose hook causes OOPS when Weston exits in the
middle of rendering - fixed in
https://git.collabora.com/cgit/user/daniels/linux.git/commit/?h=wip/4.4.x/rockchip-drm-fixes&id=d14f21bcd7e7a1b9ca129c411a9da9c911037965
and the preceding commit, which I hope to re-send for 4.4 -fixes in
the next couple of days

Hope this helps.

Cheers,
Daniel
