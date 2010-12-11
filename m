From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 11 Dec 2010 11:21:51 +0900
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <AANLkTinGHXNrL-KJiQBq8G7a_oz-gpp9-unxeS1-e5-x@mail.gmail.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<201012080902.37859.jeremy.kerr@canonical.com>
	<4CFFB6DD.4000108@fluff.org>
	<201012091016.54130.jeremy.kerr@canonical.com>
	<AANLkTinGHXNrL-KJiQBq8G7a_oz-gpp9-unxeS1-e5-x@mail.gmail.com>
Message-ID: <AANLkTimucN+feao11U3sn5P8nR9Odu8OmLcaOz+bLJ_1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 11, 2010 at 12:09 AM, Richard Zhao <linuxzsc@gmail.com> wrote:

>>> Why do they need atomic clocks?
just the question in my mind...

> atomic clock make it easy to use, or we have to move many irq tasks to
> kthread context. we may involves many kthreads. If we put tasks to
> global work queue, ?sometimes it conflicts each other, and causes dead
> lock.
Sounds like more of a requirement of convenience, than technical limitation.
See below..

> Cases to use atomic clock: when insert a sd card, we have to enable sd
> host controller clock.
One does have to enable the HC clock ... but why only in the irq context
of the OOB signal ?

> when a dma call back tell you everything is
> done, you may want to disable controller clock. ...
Again, why can't you disable the clock later?
I doubt if power saving should be the reason here.

IMHO, we should have atomic clocks only if there is really
no other alternative.
Making it available in standard API will only make its (ab)use
more common.
Also, it might get difficult to upgrade the API in future if there
are two different types of clocks to manage.

Thanks.
