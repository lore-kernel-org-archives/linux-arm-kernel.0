From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 19 Nov 2009 11:44:14 +0900
Subject: [PATCH 09/19] drivers: serial: add support for Samsung S5PC110
	SoC uart
In-Reply-To: <20091118221345.GB4808@trinity.fluff.org>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258551194-16018-10-git-send-email-m.szyprowski@samsung.com>
	<1b68c6790911180614y355f656fs828177ecc845ec8e@mail.gmail.com>
	<20091118221345.GB4808@trinity.fluff.org>
Message-ID: <1b68c6790911181844p3fb32525h11f79f942afb2d64@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 7:13 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Nov 18, 2009 at 11:14:52PM +0900, jassi brar wrote:
>> On Wed, Nov 18, 2009 at 10:33 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>> > From: Kyungmin Park <kyungmin.park@samsung.com>
>> >
>> > Samsung S5PC110 SoCs have UART that differs a bit from the one known
>> > from the previous Samsung SoCs. This patch adds support for this new
>> > driver.
>> >
>> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
>> Not just about this c110 patch: I think this string comparison thing
>> isn't very neat.
>> I think we'd better be doing it by indexing into an array of clock
>> names(which can be
>> defined in some platform specific code).
>
> I don't mind changing to using a table, but the table is probably best
> off here, closest to the UART drivers in question.
well as per current implementation of drivers/serial/samsung.c we can't
do much about it.

Ideally, each SoC(if not yet, maybe in future) can have different
number/names of possible source clocks for signal generation. Let us
not depend upon even defaults(fclk, pclk etc)
Let each platform code(SoC specific) define names of all possible
source clocks and let the board init code pass on the potential source
clocks by some bit-mask(or some other mechanism) while setting the
platform data.
The samsung.c could then simply go thru the array of source clock
names and the bit-mask, in platform_data, while selecting the best possible
 source for the baud rate under consideration.
