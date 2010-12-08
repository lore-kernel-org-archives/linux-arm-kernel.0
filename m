From: davidb@codeaurora.org (David Brown)
Date: Wed, 8 Dec 2010 09:50:00 -0800
Subject: [PATCH RFC] arm: Add argument to init_machine
In-Reply-To: <20101208172732.GQ9777@n2100.arm.linux.org.uk>
References: <1291768976-7773-1-git-send-email-davidb@codeaurora.org>
	<20101208140722.GD9777@n2100.arm.linux.org.uk>
	<20101208172423.GA18569@huya.qualcomm.com>
	<20101208172732.GQ9777@n2100.arm.linux.org.uk>
Message-ID: <20101208175000.GA20265@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 05:27:32PM +0000, Russell King - ARM Linux wrote:

> Well, that depends on how you're going to use this.
> 
> Generally, we find that it's best to arrange the common stuff as
> libraries, and have the platform specific code call the library
> functions to perform the common work.
> 
> Calling a common function from the platform methods and putting
> lots of if (machine_is_xxx()) in it certainly isn't the right method.

The idea is to reduce the machine_is_xxx() calls.  I'll have a clearer
patch soon, but it basically lets us need only one machine init
function for a group of boards, so instead of something like:

	void board1_init(void)
	{
		init_thing(parameter1);
		init_stuff(parameter2);
	}

	void board2_init(void)
	{
		init_thing(parameter1b);
		init_stuff(parameter2b);
	}

(or having machine_is_xxx() calls): we end up with

	void board_family_init(void *arg)
	{
		struct board_family_data *priv = arg;

		init_thing(priv->parameter1);
		init_stuff(priv->parameter2);
	}

I do share a bit of the concern that the mechanism can be abused, but
I've also found that nearly everything in the board files gets abused.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
