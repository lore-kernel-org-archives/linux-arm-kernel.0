From: ccross@google.com (Colin Cross)
Date: Tue, 1 Jul 2014 16:06:33 -0700
Subject: Android and compatibility with deprecated armv7 instructions
Message-ID: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I know this has been discussed before (for example:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210309.html),
but I thought I'd bring it up again before the Android ABI diverges
from the upstream kernel.

Android armv8 devices expect to have compatibility with existing
native apps, many of which contain deprecated instructions.  For
example, the Unity gaming engine used SWP until Unity 3.5, and many
apps compiled against older versions are still in the app store.
These apps have been running fine with SWP emulation on all recent
Android devices with SMP v7 cpus, so they are obviously fine with the
slowdown of emulation, and they haven't recompiled against a newer
Unity version for 2 years so it is unrealistic to expect them to be
updated.  I've also been told Unity used CP15 barriers.

ffmpeg is widely used in popular Android apps and uses the SETEND
instruction: https://ffmpeg.org/pipermail/ffmpeg-cvslog/2013-August/067252.html

We can carry patches to enable the deprecated armv7 instructions in a
tree shared by all Android vendors, but it seems like a silly reason
to diverge from the upstream kernel.  To maintain a consistent ABI for
all devices we're going to have to test for these instructions in the
Android compatibility test suite, and the upstream kernel wouldn't
pass.

Would you consider taking support for SWP emulation, enabling CP15
barriers (CP15BEN bit only until there's a real device that needs
emulation, also requires clearing COMPAT_PSR_E_BIT in
compat_setup_return) and enabling SETEND, all behind a default-off
CONFIG_DEPRECATED_ARMV7_COMPAT?
