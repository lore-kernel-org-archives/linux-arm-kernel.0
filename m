From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 May 2010 14:15:20 +0100
Subject: [PATCH] Handle instruction cache maintenance fault properly
In-Reply-To: <AANLkTikIbI6hKoYSZlo6QDlyi2Qjxg287i-ilHpz1FF9@mail.gmail.com>
References: <AANLkTikIbI6hKoYSZlo6QDlyi2Qjxg287i-ilHpz1FF9@mail.gmail.com>
Message-ID: <20100510131519.GB7796@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 04:07:57PM +0300, Kirill A. Shutemov wrote:
> Between "clean D line..." and "invalidate I line" operations in
> v7_coherent_user_range(), the memory page may get swapped out.
> And the fault on "invalidate I line" could not be properly handled
> causing the oops.

You have to be very careful when doing this kind of change - you need to
review the behaviour of previous ARMs to ensure that you don't throw the
CPU into an infinite loop when an "external abort on linefetch" occurs.

With older CPUs, an "external abort on linefetch" is most probably fatal
to the process and can never be recovered.
