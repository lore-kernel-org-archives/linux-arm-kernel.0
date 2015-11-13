From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 13 Nov 2015 14:00:39 -0800
Subject: [PATCH 1/3] mtd: create a partition type device tree binding
In-Reply-To: <CAL_JsqL2F3p7qBPbOiGytVyzF_aNLWbrCT0mAX1WZo6SxE3JoA@mail.gmail.com>
References: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
 <20151029162908.GA13275@localhost>
 <CACRpkdYS5Jf8UC2K0bNdEQZDjTeZZx44Uu-kkof+9E=4Ny0oDg@mail.gmail.com>
 <20151030175145.GF13239@google.com>
 <CAL_JsqL2F3p7qBPbOiGytVyzF_aNLWbrCT0mAX1WZo6SxE3JoA@mail.gmail.com>
Message-ID: <20151113220039.GA74382@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 08:13:13AM -0600, Rob Herring wrote:
> Since we now have partitions contained in a sub node, how about using
> compatible for that sub node instead.

I see that Linus and I spoke up in agreement on this one.

I took a little look at adding of_match_table support to the core MTD
partitioning code (not sure if that's duplicating anything Linus was
attempting on his own?), and I'm observing that there's potential for
conflict with the new binding [1]. If we're going to start overloading
the 'partitions' node to support other partitioning types via
'compatible' property, then we either need to:

 (1) go back to specifying that full ofpart specifications must have
 *no* compatible property or

 (2) we should define a comptible property for the hard-coded
 partitioning case (e.g., compatible = "partitions")

IOW, I could imagine a new partition parser that needs a DT like this:

	flash at xxx {
		compatible = "vendor,flash-type";
		...
		partitions {
			compatible = "some-new-partition-parser";
			...
			subnode {
				// "some-new-partition-parser" might
				// need to put something here
			};
		};
	};

But currently, the binding would say that 'subnode' must be a partition,
even if it's really something else auxiliary to
"some-new-partition-parser" [2].

If we went with option (1), then we'd just have ofpart.c see that
'partitions' has a compatible property and bail out. That seems kinda
hacky.

If we went with option (2), then ofpart.c could just check only for
'compatible = "partitions"' (or similar), and if not found bail out.

I think option (2) makes more sense. But it would require an update to
the binding and code for 4.4, since [1] was only introduced during this
release cycle.

Brian

[1] fe2585e9c29a ("doc: dt: mtd: support partitions in a special 'partitions' subnode")

[2] Possibilities: something relevant to partition splitting. See some
previous work, which I haven't gotten around to fully addressing yet,
but can hopefully be rolled into this work:

http://patchwork.ozlabs.org/patch/476373/
http://patchwork.ozlabs.org/patch/473364/
http://patchwork.ozlabs.org/patch/475988/
